using Microsoft.AspNetCore.Mvc;
using Timetables.Application.UseCases;

namespace Timetables.WebApi.Controllers.V1;

[ApiController]
[Route("api/v1/[controller]")]
public class RoutesController : ControllerBase
{
	private readonly GetNextScheduledTime _getNextScheduledTime;

	public RoutesController(GetNextScheduledTime getNextScheduledTime)
	{
		_getNextScheduledTime = getNextScheduledTime;
	}

	[HttpGet("{routeId}/stops/{stopId}/next-bus-time")]
    public async Task<ActionResult<Route>> GetNextBusTime([FromRoute] int routeId, [FromRoute] int sotpId)
    {
        var timetables = await _getNextScheduledTime.Execute(0, 0);
        return Ok(timetables);
    }
}