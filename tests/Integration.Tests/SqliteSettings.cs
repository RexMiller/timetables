using Timetables.Infrastructure.Sqlite;

namespace Integration.Tests;

internal class SqliteSettings : ISqliteSettings
{
	public string DirectoryName { get; init; } = ".";
	public string FileName { get; init; } = "TestData";
	public string InitFileName { get; init; } = "TestInit";

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