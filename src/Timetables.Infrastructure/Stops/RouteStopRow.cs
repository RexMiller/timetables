namespace Timetables.Infrastructure.Stops;

internal sealed record RouteStopRow
{
	public int StopId { get; init; }
	public string StopName { get; init; } = string.Empty;
	public int StopNumber { get; init; }
	public string Route { get; init; } = string.Empty;
	public string Subroute { get; init; } = string.Empty;
	public bool IsActive { get; init; }
}
