namespace Timetables.Infrastructure.Stops;

internal sealed record StopTimeRow
{
	public int StopId { get; init; }
	public string StopName { get; init; } = string.Empty;
	public int StopNumber { get; init; }
	public int StopIsActive { get; init; }
	public string Time { get; init; } = string.Empty;
	public string DayCategory { get; init; } = string.Empty;
	public string Route { get; init; } = string.Empty;
	public string Subroute { get; init; } = string.Empty;
}
