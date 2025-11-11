using Microsoft.Extensions.Options;
using Timetables.Application.Interfaces;
using Timetables.Application.UseCases.NextScheduledTime;
using Timetables.Infrastructure.Sqlite;
using Timetables.Infrastructure.Stops;
using UseCaseGetStops = Timetables.Application.UseCases.GetStops.UseCase;
using UseCaseNextScheduledTime = Timetables.Application.UseCases.NextScheduledTime.UseCase;

namespace Timetables.WebApi.Configuration;

public static class DependencyRegistration
{
	public static IServiceCollection ConfigureServices(this IServiceCollection services, ConfigurationManager configuration)
	{
		services
			.Configure<LocalTime>(configuration.GetSection(nameof(LocalTime)))
			.Configure<SqliteSettings>(configuration.GetSection(nameof(SqliteSettings)));

		services
			.AddScoped<UseCaseGetStops>()
			.AddScoped<UseCaseNextScheduledTime>()
			.AddScoped<IStopsRepository, StopsRepository>()
			.AddScoped<DatabaseInitializer>();

		services
			.AddSingleton<LocalTime>(x => x.GetRequiredService<IOptions<LocalTime>>().Value)
			.AddSingleton<ISqliteSettings>(x => x.GetRequiredService<IOptions<SqliteSettings>>().Value)
			.AddSingleton<ConnectionStringFactory>();

		return services;
	}
}
