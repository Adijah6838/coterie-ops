var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();
builder.Services.AddHealthChecks(); // <-- Added for Docker/K8s

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    // Development only middleware could go here
}

app.UseHttpsRedirection();
app.UseAuthorization();

// Add the health check endpoint (e.g., /health)
app.MapHealthChecks("/health");

app.MapControllers();

app.Run();