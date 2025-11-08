namespace Timetables.Infrastructure.Sqlite;

public sealed class ConnectionStringFactory
{
	private readonly ISqliteSettings _settings;

	public ConnectionStringFactory(ISqliteSettings settings)
	{
		_settings = settings;
	}

	public string Create()
	{
		return $"Data Source={_settings.FileAbsolutePath()}";
	}

	public string FileAbsolutePath()
	{
		return Path.Combine($"{_settings.DirectoryAbsolutePath()}", $"{_settings.FileName}.sqlite");
	}
}
