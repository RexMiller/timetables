using Dapper;
using Microsoft.Data.Sqlite;
using Timetables.Domain.Interfaces;
using Timetables.Domain.Models;
using Timetables.Infrastructure.Sqlite;

namespace Timetables.Infrastructure.Stops;

public sealed class StopsRepository : IStopsRepository
{
	private readonly ConnectionStringFactory _conStringFactory;

	public StopsRepository(ConnectionStringFactory conStringFactory)
	{
		_conStringFactory = conStringFactory;
	}

	public async Task<(bool Ok, Stop? Value, string? Error)> GetByNumber(int number)
	{
		var conString = _conStringFactory.Create();

		var query = @"
			SELECT 
				r.RouteId,
				r.Name as Route,
				sr.Description as Subroute
				rs.StopId,
				rs.Name as StopName,
				rs.Number as StopNumber,
				rs.Direction as StopDirection,
				rs.IsActive as StopIsActive,
				st.Time,
				st.DayCategory
			FROM RouteStops as rs
			INNER JOINT SubRoutes as sr
				ON rs.SubRouteId = sr.SubRouteId
			INNER JOIN Routes as r
				ON rs.RouteId = r.RouteId
			INNER JOIN StopTimes as st
				ON st.StopId = rs.StopId
			WHERE rs.Number = @number;";


		try
		{
			using var con = new SqliteConnection(conString);
			var rows = (await con.QueryAsync<StopTimeRow>(query, new { number })).ToList();
			if (rows.Count == 0)
			{
				return (false, default, "no stop data available");
			}

			return (true, rows.ToStop(), default);
		}
		catch (Exception ex)
		{
			// I would prefer to log the exception and
			// return an error object more suitable to
			// the consumer
			return (false, default, $"{ex.Message}");
		}
	}

	public async Task<(bool Ok, Stop[] Stops, string? Error)> GetByRoute(int routeId)
	{
		var conString = _conStringFactory.Create();

		var query = @"
			SELECT
				rs.StopId,
				rs.Name as StopName,
				rs.Number as StopNumber,
				r.Name as Route,
				sr.Description as Subroute,
				rs.IsActive as IsActive
			FROM RouteStops as rs
			INNER JOIN SubRoutes as sr
				ON rs.SubRouteId = sr.SubRouteId
			INNER JOIN Routes as r
				ON rs.RouteId = r.RouteId				
			WHERE rs.RouteId = @routeId;";

		try
		{
			using var con = new SqliteConnection(conString);
			var rows = (await con.QueryAsync<RouteStopRow>(query, new { routeId })).ToList();
			if (rows.Count == 0)
			{
				return (false, [], "no stop data available");
			}

			return (true, rows.ToStops(), default);
		}
		catch (Exception ex)
		{
			return (false, [], $"{ex.Message}");
		}
	}
}
