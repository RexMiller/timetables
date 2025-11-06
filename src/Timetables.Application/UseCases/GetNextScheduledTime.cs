using Timetables.Application.Contracts;
using Timetables.Application.Models;

namespace Timetables.Application.UseCases;

public sealed class GetNextScheduledTime
{
	private readonly IRoutesRepository _routes;

	public GetNextScheduledTime(IRoutesRepository routes)
	{
		_routes = routes;
	}

	public async Task<Route> Execute(int routeId, int stopId)
	{
		var routes = await _routes.Get(routeId);

		await Task.CompletedTask;
		return routes;
	}
}
