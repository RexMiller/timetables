using Timetables.Infrastructure.Sqlite;

namespace Timetables.WebApi.Configuration;

public sealed record SqliteSettings : ISqliteSettings
{
	public string DirectoryName { get; init; } = string.Empty;
	public string FileName { get; init; } = string.Empty;
	public string InitFileName { get; init; } = string.Empty;

	public string FileAbsolutePath()
	{
		return Path.Combine($"{DirectoryAbsolutePath()}", $"{FileName}.sqlite");
	}

	public string DirectoryAbsolutePath()
	{
		var currentDir = Directory.GetCurrentDirectory();
		return Path.Combine(currentDir, @"../..", $"{DirectoryName}");
	}
}
