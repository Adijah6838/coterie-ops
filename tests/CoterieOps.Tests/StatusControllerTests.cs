using Microsoft.AspNetCore.Mvc;
using CoterieOps.Api.Controllers;
using Xunit;

namespace CoterieOps.Tests;

public class StatusControllerTests
{
    [Fact]
    public void GetStatus_ReturnsOkResult()
    {
        // Arrange
        var controller = new StatusController();

        // Act
        var result = controller.GetStatus();

        // Assert
        var okResult = Assert.IsType<OkObjectResult>(result);
        Assert.NotNull(okResult.Value);
    }
}