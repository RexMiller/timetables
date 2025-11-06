using Timetables.Application.Contracts;
using Timetables.Application.UseCases;
using Timetables.Infrastructure;

namespace Timetables.WebApi;

public static class DependencyRegistration
{
	public static IServiceCollection ConfigureServices(this IServiceCollection services, ConfigurationManager configuration)
	{
		services
			.AddScoped<GetNextScheduledTime>()
			.AddScoped<IRoutesRepository, RoutesRepository>();

		return services;
	}
}
