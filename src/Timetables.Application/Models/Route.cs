namespace Timetables.Application.Models;

public sealed record Route
{
	public int Id { get; init; }
	public string Name { get; init; } = string.Empty;
	public RouteDirection Direction { get; init; }
	public DayCategory[] ActiveDays { get; init; } = [];
	public Stop[] Stops { get; init; } = [];
}
