using Moq;
using Timetables.Application.Interfaces;
using Timetables.Application.UseCases.GetStops;
using Timetables.Domain.Models;
using Xunit;

namespace Application.Tests;

public class GetStopsUseCaseTests
{
	[Fact]
	public async Task CallsRepositoryToGetData()
	{
		var stops = new Stop[] { new() };

		var repo = new Mock<IStopsRepository>();
		repo.Setup(x => x.GetByRoute(It.IsAny<int>())).ReturnsAsync((true, stops, default));

		var useCase = new UseCase(repo.Object);

		_ = await useCase.Execute(1);

		repo.Verify(x => x.GetByRoute(1), Times.Once);
	}

	[Fact]
	public async Task RepositoryError_StopsUnavailableWithMessage()
	{
		var repo = new Mock<IStopsRepository>();
		repo.Setup(x => x.GetByRoute(It.IsAny<int>())).ReturnsAsync((false, [], "error"));

		var useCase = new UseCase(repo.Object);

		var result = await useCase.Execute(1);

		Assert.False(result.AreAvailable);
		Assert.NotNull(result.Message);
	}


	[Fact]
	public async Task NoStopsFoundForRoute_StopsUnavailableWithMessage()
	{
		var repo = new Mock<IStopsRepository>();
		repo.Setup(x => x.GetByRoute(It.IsAny<int>())).ReturnsAsync((true, [], default));

		var useCase = new UseCase(repo.Object);

		var result = await useCase.Execute(1);

		Assert.False(result.AreAvailable);
		Assert.NotNull(result.Message);
	}

	[Fact]
	public async Task StopsFound_GetsStops()
	{
		var stops = new Stop[] { new() };

		var repo = new Mock<IStopsRepository>();
		repo.Setup(x => x.GetByRoute(It.IsAny<int>())).ReturnsAsync((true, stops, default));

		var useCase = new UseCase(repo.Object);

		var result = await useCase.Execute(1);

		Assert.True(result.AreAvailable);
	}
}
