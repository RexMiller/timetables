using Timetables.Domain.Interfaces;

namespace Timetables.Application.UseCases.NextScheduledTime;


public sealed class UseCase
{
	private readonly IStopsRepository _stops;
	private readonly LocalTime _localTime;

	public UseCase(IStopsRepository stops, LocalTime localTime)
	{
		_stops = stops;
		_localTime = localTime;
	}

	public async Task<ViewModel> Execute(int stopNumber)
	{
		var (ok, stop, err) = await _stops.GetByNumber(stopNumber);

		if (!ok || stop == null)
		{
			return ViewModel.Unavailable(err ?? "error getting stop data");
		}

		return stop.FindNextTimeFromNow(_localTime.TimeZone);
	}
}
