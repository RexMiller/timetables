using Timetables.Domain.Models;

namespace Timetables.Infrastructure.Stops;

internal static class Mapping
{
	public static Stop[] ToStops(this List<RouteStopRow> rows)
	{
		var stops = rows.Select(r => new Stop
		{
			Id = r.StopId,
			Name = r.StopName,
			Number = r.StopNumber,
			Route = r.Route,
			Subroute = r.Subroute,
			IsActive = r.IsActive
		});

		return [.. stops];
	}

	public static Stop ToStop(this List<StopTimeRow> rows)
	{
		if (!rows.Any()) { return new Stop(); }

		var row = rows.First();

		return new Stop
		{
			Id = row.StopId,
			IsActive = row.StopIsActive > 0,
			Name = row.StopName,
			Number = row.StopNumber,
			Schedules = rows.ToSchedules(),
			Route = row.Route,
			Subroute = row.Subroute
		};
	}

	private static Schedule[] ToSchedules(this IEnumerable<StopTimeRow> rows)
	{
		var schedules = rows.GroupBy(row => row.DayCategory)
			.Select(grp => new Schedule
			{
				DayCategory = grp.Key.AsEnum<DayCategory>(),
				Times = [.. grp.Select(timeEntry => timeEntry.Time.AsTimeOnly())]
			});

		return [.. schedules];
	}

	private static T AsEnum<T>(this string value)
		where T : struct => Enum.TryParse<T>(value, ignoreCase: true, out var t) ? t : default(T);

	private static TimeOnly AsTimeOnly(this string value) =>
		TimeOnly.TryParse(value, out var time) ? time : TimeOnly.MinValue;
}
