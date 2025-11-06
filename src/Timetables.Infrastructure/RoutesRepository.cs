using Timetables.Application.Contracts;
using Timetables.Application.Models;

namespace Timetables.Infrastructure;

public class RoutesRepository : IRoutesRepository
{
	public async Task<Route> Get(int id)
	{
		await Task.CompletedTask;
		return new Route
		{
			Id = 1,
			Name = "F"
		};
	}

	public Task<Route[]> Get()
	{
		throw new NotImplementedException();
	}
}
