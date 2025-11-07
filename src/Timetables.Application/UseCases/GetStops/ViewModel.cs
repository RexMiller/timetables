using Timetables.Domain.Models;

namespace Timetables.Application.UseCases.GetStops;

public sealed record ViewModel
{
	public Subroute[] Subroutes { get; init; } = [];
	public bool AreAvailable { get; init; } = true;
	public string? Message { get; init; }

	public sealed record Subroute
	{
		public string Description { get; set; } = string.Empty;
		public RouteStop[] Stops { get; init; } = [];
	}

	public sealed record RouteStop
	{
		public string Name { get; init; } = string.Empty;
		public int Number { get; init; }
		public bool IsActive { get; init; }
	}

	public static ViewModel FromStops(Stop[] stops)
	{
		var subroutes = stops.GroupBy(s => s.Subroute).Select(sr => new Subroute
		{
			Description = sr.Key,
			Stops = [
				.. sr.Select(s => new RouteStop
				{
					Name = s.Name,
					Number = s.Number,
					IsActive = s.IsActive
				})],
		});

		return new ViewModel { Subroutes = [.. subroutes] };
	}

	public static ViewModel Unavailable(string message)
	{
		return new ViewModel
		{
			AreAvailable = false,
			Message = message
		};
	}
}
