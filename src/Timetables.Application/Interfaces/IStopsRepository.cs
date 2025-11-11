using Timetables.Domain.Models;

namespace Timetables.Application.Interfaces;

public interface IStopsRepository
{
	Task<(bool Ok, Stop? Value, string? Error)> GetByNumber(int number);
	Task<(bool Ok, Stop[] Stops, string? Error)> GetByRoute(int routeId);
}
