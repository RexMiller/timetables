using Timetables.Infrastructure.Sqlite;

namespace Timetables.WebApi.Configuration;

internal static class SqliteConfigurator
{
	public static void ConfigureDatabase(this WebApplication app)
	{
		using var scope = app.Services.CreateScope();

		var services = scope.ServiceProvider;
		var settings = services.GetRequiredService<ISqliteSettings>();
		var conStringFactory = services.GetRequiredService<ConnectionStringFactory>();
		var filePath = settings.FileAbsolutePath();
		var directory = settings.DirectoryAbsolutePath();

		if (!File.Exists(filePath))
		{
			if (!Directory.Exists(directory))
			{
				Directory.CreateDirectory(directory);
			}

			var initializer = services.GetRequiredService<DatabaseInitializer>();
			initializer.Initialize();
		}
	}
}