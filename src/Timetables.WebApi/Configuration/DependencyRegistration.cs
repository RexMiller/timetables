using Microsoft.Extensions.Options;
using Timetables.Application.UseCases.NextScheduledTime;
using Timetables.Domain.Interfaces;
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
			.Configure<SqlLiteSettings>(configuration.GetSection(nameof(SqlLiteSettings)));

		services
			.AddScoped<UseCaseGetStops>()
			.AddScoped<UseCaseNextScheduledTime>()
			.AddScoped<IStopsRepository, StopsRepository>()
			.AddScoped<DatabaseInitializer>();

		services
			.AddSingleton<LocalTime>(x => x.GetRequiredService<IOptions<LocalTime>>().Value)
			.AddSingleton<SqlLiteSettings>(x => x.GetRequiredService<IOptions<SqlLiteSettings>>().Value)
			.AddSingleton<ConnectionStringFactory>();

		return services;
	}
}
