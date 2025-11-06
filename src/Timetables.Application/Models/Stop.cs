namespace Timetables.Application.Models;

public sealed record Stop
{
	public int Id { get; init; }
	public string Name { get; init; } = string.Empty;
	public bool IsActive { get; init; }
	public Schedule[] Schedules { get; init; } = [];
}
