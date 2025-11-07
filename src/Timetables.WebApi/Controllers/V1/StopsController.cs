using Microsoft.AspNetCore.Mvc;

using UseCaseGetStops = Timetables.Application.UseCases.GetStops.UseCase;
using UseCaseNextScheduledTime = Timetables.Application.UseCases.NextScheduledTime.UseCase;

using ViewRouteStops = Timetables.Application.UseCases.GetStops.ViewModel;
using ViewNextScheduledTime = Timetables.Application.UseCases.NextScheduledTime.ViewModel;

namespace Timetables.WebApi.Controllers.V1;

[ApiController]
[Route("api/v1/[controller]")]
public class StopsController : ControllerBase
{
	private readonly UseCaseGetStops _getStops;
	private readonly UseCaseNextScheduledTime _getNextScheduledTime;

	public StopsController(UseCaseGetStops getStops, UseCaseNextScheduledTime getNextScheduledTime)
	{
		_getStops = getStops;
		_getNextScheduledTime = getNextScheduledTime;
	}

	[HttpGet("{stopNumber}/next-bus-time")]
	public async Task<ActionResult<ViewNextScheduledTime>> GetNextBusTime([FromRoute] int stopNumber)
	{
		var nextTime = await _getNextScheduledTime.Execute(stopNumber);
		return Ok(nextTime);
	}

	[HttpGet("for-route/{routeId}")]
	public async Task<ActionResult<ViewRouteStops>> GetStops([FromRoute] int routeId)
	{
		var stops = await _getStops.Execute(routeId);
		return Ok(stops);
	}
}