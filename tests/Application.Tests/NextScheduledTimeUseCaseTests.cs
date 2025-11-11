using Moq;
using Timetables.Application.Interfaces;
using Timetables.Application.UseCases.NextScheduledTime;
using Timetables.Domain.Models;
using Xunit;

namespace Application.Tests;

public class NextScheduledTimeUseCaseTests
{
	[Fact]
	public async Task CallsRepositoryToGetData()
	{
		var nowLocal = DateTime.Now;
		var stop = StopWithUpcomingTimes(nowLocal);

		var repo = new Mock<IStopsRepository>();
		repo.Setup(x => x.GetByNumber(It.IsAny<int>())).ReturnsAsync((true, stop, default));

		var localTimeZone = new LocalTime { TimeZoneIdString = TimeZoneInfo.Local.Id };
		var useCase = new UseCase(repo.Object, localTimeZone);

		_ = await useCase.Execute(stop.Number);

		repo.Verify(x => x.GetByNumber(stop.Number), Times.Once);
	}

	[Fact]
	public async Task RepositoryError_NextTimeUnvailableWithMessage()
	{
		var nowLocal = DateTime.Now;
		var stop = StopWithUpcomingTimes(nowLocal);

		var repo = new Mock<IStopsRepository>();
		repo.Setup(x => x.GetByNumber(It.IsAny<int>())).ReturnsAsync((false, default, "error"));

		var localTimeZone = new LocalTime { TimeZoneIdString = TimeZoneInfo.Local.Id };
		var useCase = new UseCase(repo.Object, localTimeZone);

		var nextTime = await useCase.Execute(stop.Number);

		Assert.False(nextTime.IsAvailable);
		Assert.NotNull(nextTime.Message);
	}

	[Fact]
	public async Task TimesAvailable_GetsNextTime()
	{

		var nowLocal = DateTime.Now;
		var stop = StopWithUpcomingTimes(nowLocal);

		var repo = new Mock<IStopsRepository>();
		repo.Setup(x => x.GetByNumber(It.IsAny<int>())).ReturnsAsync((true, stop, default));

		var localTimeZone = new LocalTime { TimeZoneIdString = TimeZoneInfo.Local.Id };
		var useCase = new UseCase(repo.Object, localTimeZone);

		var nextTime = await useCase.Execute(stop.Number);

		Assert.True(nextTime.IsAvailable);
	}

	[Fact]
	public async Task NoTimesAvailable_NextTimeUnvailableWithMessage()
	{

		var nowLocal = DateTime.Now;
		var stop = new Stop { Number = 1 };

		var repo = new Mock<IStopsRepository>();
		repo.Setup(x => x.GetByNumber(It.IsAny<int>())).ReturnsAsync((true, stop, default));

		var localTimeZone = new LocalTime { TimeZoneIdString = TimeZoneInfo.Local.Id };
		var useCase = new UseCase(repo.Object, localTimeZone);

		var nextTime = await useCase.Execute(stop.Number);

		Assert.False(nextTime.IsAvailable);
		Assert.NotNull(nextTime.Message);
	}

	private static Stop StopWithUpcomingTimes(DateTime nowLocal)
	{
		var weekdaySchedule = new Schedule
		{
			DayCategory = DayCategory.Weekday,
			Times = [TimeOnly.FromDateTime(nowLocal.AddMinutes(5))]
		};

		var weekendSchedule = new Schedule
		{
			DayCategory = DayCategory.Weekend,
			Times = [TimeOnly.FromDateTime(nowLocal.AddMinutes(5))]
		};

		var stop = new Stop
		{
			Number = 1,
			Schedules = [weekdaySchedule, weekendSchedule]
		};
		return stop;
	}
}
