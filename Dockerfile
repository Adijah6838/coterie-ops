# Stage 1: Build & Test
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy csproj files and restore dependencies (caching layer)
COPY ["src/CoterieOps.Api/CoterieOps.Api.csproj", "src/CoterieOps.Api/"]
COPY ["tests/CoterieOps.Tests/CoterieOps.Tests.csproj", "tests/CoterieOps.Tests/"]
RUN dotnet restore "src/CoterieOps.Api/CoterieOps.Api.csproj"
RUN dotnet restore "tests/CoterieOps.Tests/CoterieOps.Tests.csproj"

# Copy everything else and build
COPY . .
RUN dotnet build "src/CoterieOps.Api/CoterieOps.Api.csproj" -c Release -o /app/build

# Stage 2: Publish
FROM build AS publish
RUN dotnet publish "src/CoterieOps.Api/CoterieOps.Api.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Stage 3: Final Runtime Image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=publish /app/publish .

# Advanced Requirement: Container health check
# Installs curl in the runtime image to ping the /health endpoint
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/health || exit 1

# Expose port 8080 (ASP.NET Core 8 default for containers)
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

ENTRYPOINT ["dotnet", "CoterieOps.Api.dll"]