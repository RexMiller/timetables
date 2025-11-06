using Timetables.Application.Models;

namespace Timetables.Application.Contracts;

public interface IRoutesRepository
{
	Task<Route> Get(int id);
	Task<Route[]> Get();
}
