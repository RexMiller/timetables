using Timetables.Domain.Models;
using Timetables.Infrastructure.Stops;
using Xunit;

namespace Integration.Tests;

public class StopsRepositoryTests : IClassFixture<DatabaseFixture>
{
	[Fact]
	public async Task GetStops()
	{
		var repo = new StopsRepository(DatabaseFixture.ConStringFactory);
		var (_, stops, _) = await repo.GetByRoute(1);

		Assert.NotEmpty(stops);
	}

	[Fact]
	public async Task GetByStopNumber()
	{
		var repo = new StopsRepository(DatabaseFixture.ConStringFactory);
		var (ok, stop, _) = await repo.GetByNumber(6139);

		Assert.True(ok);
		Assert.NotNull(stop);
	}

	[Fact]
	public async Task GetByStopNumber_HasSubroute()
	{
		var repo = new StopsRepository(DatabaseFixture.ConStringFactory);
		var (ok, stop, _) = await repo.GetByNumber(6139);

		Assert.NotNull(stop?.Subroute);
	}

	[Fact]
	public async Task GetByStopNumber_HasWeekdayAndWeekendSchedules()
	{
		var repo = new StopsRepository(DatabaseFixture.ConStringFactory);
		var (ok, stop, _) = await repo.GetByNumber(6139);

		Assert.Contains(stop!.Schedules, x => x.DayCategory == DayCategory.Weekday);
		Assert.Contains(stop!.Schedules, x => x.DayCategory == DayCategory.Weekend);
	}
}
