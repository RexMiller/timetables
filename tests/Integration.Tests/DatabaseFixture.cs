using Timetables.Infrastructure.Sqlite;

namespace Integration.Tests;

public class DatabaseFixture : IDisposable
{
	private static readonly SqliteSettings sqliteSettings = new();
	public static readonly ConnectionStringFactory ConStringFactory = new(sqliteSettings);

	public DatabaseFixture()
	{
		var initializer = new DatabaseInitializer(ConStringFactory, sqliteSettings);
		initializer.Initialize();
	}

	public void Dispose()
	{
		File.Delete(ConStringFactory.FileAbsolutePath());
	}
}
