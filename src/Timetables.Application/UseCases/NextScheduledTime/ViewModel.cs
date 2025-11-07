using Timetables.Domain.Models;

namespace Timetables.Application.UseCases.NextScheduledTime;

public sealed record ViewModel
{
	public string Route { get; init; } = string.Empty;
	public string Description { get; init; } = string.Empty;
	public string DayOfWeek { get; init; } = string.Empty;
	public string Date { get; init; } = string.Empty;
	public string Time { get; init; } = string.Empty;
	public bool IsAvailable { get; init; } = true;
	public string? Message { get; init; }

	private ViewModel() { }

	public static ViewModel ForStop(Stop stop, DateOnly date, TimeOnly time)
	{
		return new ViewModel
		{
			Route = $"{stop.Route} {stop.Subroute}",
			Description = stop.Description,
			DayOfWeek = date.DayOfWeek.ToString(),
			Date = date.ToShortDateString(),
			Time = time.ToShortTimeString()
		};
	}

	public static ViewModel Unavailable(string message)
	{
		return new ViewModel
		{
			IsAvailable = false,
			Message = message
		};
	}
}