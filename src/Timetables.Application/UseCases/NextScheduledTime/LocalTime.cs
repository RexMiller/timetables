namespace Timetables.Application.UseCases.NextScheduledTime;

public sealed record LocalTime
{
	public string TimeZoneIdString { get; init; } = "Etc/UTC";
	public TimeZoneInfo TimeZone => TimeZoneInfo.FindSystemTimeZoneById(TimeZoneIdString);
}
