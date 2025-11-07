namespace Timetables.Infrastructure.Sqlite;

public sealed class ConnectionStringFactory
{
	private readonly SqlLiteSettings _settings;

	public ConnectionStringFactory(SqlLiteSettings settings)
	{
		_settings = settings;
	}

	public string Create()
	{
		return $"Data Source={FileAbsolutePath()}";
	}

	public string FileAbsolutePath()
	{
		return Path.Combine($"{DirectoryAbsolutePath()}", $"{_settings.FileName}.sqlite");
	}

	public string DirectoryAbsolutePath()
	{
		var currentDir = Directory.GetCurrentDirectory();
		return Path.Combine(currentDir, @"../..", $"{_settings.DirectoryName}");
	}
}
