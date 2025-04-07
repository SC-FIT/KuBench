using experiment.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace experiment.Controllers;

[ApiController]
[Route("api/[controller]")]
public class TestController : ControllerBase
{
    private readonly TestService _testService;
    private readonly AppDbContext _context;

    public TestController(AppDbContext context, TestService testService)
    {
        _context = context;
        _testService = testService;
    }

    private const string DEVICE_INFO = @"
        {
            ""deviceName"": ""My Awesome Device"",
            ""deviceModel"": ""Model 123"",
            ""deviceOS"": ""Android 13"",
            ""appVersion"": ""1.2.3"",
            ""deviceID"": ""unique_device_id"",
            ""screenResolution"": ""1080x1920"",
            ""carrierName"": ""Carrier X"",
            ""locale"": ""en_US"",
            ""timezone"": ""America/Los_Angeles""
        }";

    [HttpGet("/test/device")]
    public IActionResult TestDevice()
    {
        return Ok(DEVICE_INFO);
    }

    [HttpGet("/test/complex-select")]
    public async Task<IActionResult> Test()
    {
        var result = await _context.UserViews
            .FromSqlRaw(@"
    SELECT u.id AS UserId,
           g.name AS GroupName,
           g.contract_number AS ContractNumber,
           g.institute_name AS InstituteName,
           g.institute_address_name AS InstituteAddressName,
           g.city AS City,
           u.name AS UserName,
           u.surname AS UserSurname,
           u.login AS UserLogin,
           u.email AS UserEmail,
           u.phone AS UserPhone,
           s.label AS StatusName,
           u.is_dsm_admin AS IsDsmAdmin,
           u.is_group_admin AS IsGroupAdmin,
           u.is_planner AS IsPlanner,
           u.is_support_tech AS IsSupportTech,
           u.photo AS Photo
      FROM ((public.""user"" u
           JOIN public.usergroupstate s ON ((u.state_id = s.id)))
           JOIN public.""group"" g ON ((u.group_id = g.id)))")
            .ToListAsync();
    
        return Ok(result);
    }
    
    [HttpGet("/test/random-sleep")]
    public async Task<IActionResult> TestRandomSleep()
    {
        var random = new Random();
        int delay = random.Next(2000, 5000); // Sleep time between 2000 and 5000 milliseconds
        await Task.Delay(delay);
        return NoContent();
    }

    [HttpPost("/test/file-upload")]
    public async Task<IActionResult> TestFileUpload(IFormFile file)
    {
        try
        {
            await _testService.HandleFileUploadAsync(file);
            return Ok();
        }
        catch (Exception ex)
        {
            return StatusCode(StatusCodes.Status500InternalServerError, ex.Message);
        }
    }
}