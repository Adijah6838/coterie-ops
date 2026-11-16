using Microsoft.AspNetCore.Mvc;

namespace CoterieOps.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class StatusController : ControllerBase
{
    [HttpGet]
    public IActionResult GetStatus()
    {
        return Ok(new { Status = "Operational", Timestamp = DateTime.UtcNow });
    }
}