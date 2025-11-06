namespace Timetables.Application.Models;

public sealed record Schedule
{
	public DayCategory Category { get; init; }
	public int[] Times { get; init; } = [];
}
