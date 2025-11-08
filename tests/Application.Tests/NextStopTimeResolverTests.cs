using Timetables.Application.UseCases.NextScheduledTime;
using Timetables.Domain.Models;
using Xunit;

namespace Application.Tests;

public class NextStopTimeResolverTests
{
	[Fact]
	public void MoreTimesToday_GetsNextTimeToday()
	{
		var weekdayNoon = new DateTime(2025, 11, 5, 12, 0, 0, DateTimeKind.Local);

		var stop = new Stop
		{
			Schedules = [
				new Schedule {
					DayCategory = DayCategory.Weekday,
					Times = [ TimeOnly.Parse("12:05")]
				}
			]
		};

		var nextStop = stop.FindNextTimeAfter(weekdayNoon);

		Assert.Equal(weekdayNoon.Date, DateTime.Parse(nextStop.Date));
		Assert.Equal(stop.Schedules[0].Times[0], TimeOnly.Parse(nextStop.Time));
	}

	[Fact]
	public void NoMoreTimesToday_GetsFirstTimeTomorrow()
	{
		var weekdayNoon = new DateTime(2025, 11, 5, 12, 0, 0, DateTimeKind.Local);

		var stop = new Stop
		{
			Schedules = [
				new Schedule {
					DayCategory = DayCategory.Weekday,
					Times = [
						TimeOnly.Parse("08:00"),
						TimeOnly.Parse("11:00")
					]
				}
			]
		};

		var nextStop = stop.FindNextTimeAfter(weekdayNoon);

		Assert.Equal(weekdayNoon.Date.AddDays(1), DateTime.Parse(nextStop.Date));
		Assert.Equal(stop.Schedules[0].Times[0], TimeOnly.Parse(nextStop.Time));
	}

	[Fact]
	public void FridayNoMoreTimesToday_GetsFirstWeekendTime()
	{
		var fridayNoon = new DateTime(2025, 11, 7, 12, 0, 0, DateTimeKind.Local);

		var weekdaySchedule = new Schedule
		{
			DayCategory = DayCategory.Weekday,
			Times = [TimeOnly.Parse("11:00")]
		};

		var weekendSchedule = new Schedule
		{
			DayCategory = DayCategory.Weekend,
			Times = [TimeOnly.Parse("08:00")]
		};

		var stop = new Stop
		{
			Schedules = [weekdaySchedule, weekendSchedule]
		};

		var nextStop = stop.FindNextTimeAfter(fridayNoon);

		Assert.Equal(fridayNoon.Date.AddDays(1), DateTime.Parse(nextStop.Date));
		Assert.Equal(weekendSchedule.Times[0], TimeOnly.Parse(nextStop.Time));
	}

	[Fact]
	public void SundayNoMoreTimesToday_GetsFirstWeekdayTime()
	{
		var sundayNoon = new DateTime(2025, 11, 9, 12, 0, 0, DateTimeKind.Local);

		var weekdaySchedule = new Schedule
		{
			DayCategory = DayCategory.Weekday,
			Times = [TimeOnly.Parse("08:00")]
		};

		var weekendSchedule = new Schedule
		{
			DayCategory = DayCategory.Weekend,
			Times = [TimeOnly.Parse("11:00")]
		};

		var stop = new Stop
		{
			Schedules = [weekdaySchedule, weekendSchedule]
		};

		var nextStop = stop.FindNextTimeAfter(sundayNoon);

		Assert.Equal(sundayNoon.Date.AddDays(1), DateTime.Parse(nextStop.Date));
		Assert.Equal(weekdaySchedule.Times[0], TimeOnly.Parse(nextStop.Time));
	}

	[Fact]
	public void FridayNoMoreTimesTodayWeekendShutdown_NoTimesAvailable()
	{
		var fridayNoon = new DateTime(2025, 11, 7, 12, 0, 0, DateTimeKind.Local);

		var weekdaySchedule = new Schedule
		{
			DayCategory = DayCategory.Weekday,
			Times = [TimeOnly.Parse("11:00")]
		};

		var stop = new Stop
		{
			Schedules = [weekdaySchedule]
		};

		var nextStop = stop.FindNextTimeAfter(fridayNoon);
		Assert.False(nextStop.IsAvailable);
		Assert.NotNull(nextStop.Message);
	}
}
