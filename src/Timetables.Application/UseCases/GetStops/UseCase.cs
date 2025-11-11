using Timetables.Application.Interfaces;

namespace Timetables.Application.UseCases.GetStops;

public sealed class UseCase
{
	private readonly IStopsRepository _stops;

	public UseCase(IStopsRepository stops)
	{
		_stops = stops;
	}

	public async Task<ViewModel> Execute(int routeId)
	{
		var (ok, stops, err) = await _stops.GetByRoute(routeId);
		if (!ok)
		{
			return ViewModel.Unavailable(err ?? "error getting stops");
		}
		if (stops.Length == 0)
		{
			return ViewModel.Unavailable("no stops available");
		}

		return ViewModel.FromStops(stops);
	}
}
