using Timetables.Domain.Models;

namespace Timetables.Application.UseCases.NextScheduledTime;

public static class NextStopTimeResolver
{
	public static ViewModel FindNextTimeAfter(this Stop stop, DateTime nowLocal)
	{
		// try get next ocurring stop if any left today
		var next = stop.GetNextTimeFrom(nowLocal);

		// if no stop left on the current day try 
		// the following day for the next 2 days
		var daysTried = 1;
		var maxDaysToTry = 3;

		while (!next.HasValue && daysTried < maxDaysToTry)
		{
			// advance to the next day
			nowLocal = nowLocal.Date.AddDays(1);
			// and get the first stop of the next day
			next = stop.GetNextTimeFrom(nowLocal);

			daysTried++;
		}

		return next.HasValue
			? ViewModel.ForStop(stop, DateOnly.FromDateTime(nowLocal), next.Value)
			: ViewModel.Unavailable($"No stop times within {maxDaysToTry} days");
	}

	private static TimeOnly? GetNextTimeFrom(this Stop stop, DateTime nowLocal)
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
			.FirstOrDefault();

		return nextTime?.Time;
	}
}
