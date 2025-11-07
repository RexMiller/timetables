using Timetables.Domain.Models;

namespace Timetables.Application.UseCases.NextScheduledTime;

public static class NextStopTimeResolver
{
	public static ViewModel FindNextTimeFromNow(this Stop stop, TimeZoneInfo timeZone)
	{
		var nowLocal = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, timeZone);

		var maxTries = 3;
		var tryCount = 0;
		var next = stop.GetNextTimeFrom(nowLocal);

		while (next == default && tryCount < maxTries)
		{
			nowLocal = nowLocal.AddDays(1);
			next = stop.GetNextTimeFrom(nowLocal);
			tryCount++;
		}

		return next != default
			? ViewModel.ForStop(stop, DateOnly.FromDateTime(nowLocal), next)
			: ViewModel.Unavailable($"No stop times within the next {maxTries} days");
	}

	private static TimeOnly GetNextTimeFrom(this Stop stop, DateTime nowLocal)
	{
		var dayCategory = nowLocal.DayOfWeek switch
		{
			DayOfWeek.Sunday => DayCategory.Weekend,
			DayOfWeek.Saturday => DayCategory.Weekend,
			_ => DayCategory.Weekday
		};

		var nextTime = stop.Schedules
			.SelectMany(sch => sch.Times.Select(t => new { sch.DayCategory, Time = t }))
			.Where(t => t.DayCategory == dayCategory && TimeOnly.FromDateTime(nowLocal) < t.Time)
			.Select(t => t.Time)
			.FirstOrDefault();

		return nextTime;
	}
}
