namespace Timetables.Domain.Models;

public sealed record Schedule
{
	public DayCategory DayCategory { get; init; }
	public TimeOnly[] Times { get; init; } = [];
}
