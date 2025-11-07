namespace Timetables.Domain.Models;

public sealed record Stop
{
	public int Id { get; init; }
	public string Name { get; init; } = string.Empty;
	public int Number { get; init; }
	public string Route { get; init; } = string.Empty;
	public string Subroute { get; init; } = string.Empty;
	public bool IsActive { get; init; }
	public Schedule[] Schedules { get; init; } = [];
	public string Description => $"{Number} - {Name}";
}
