namespace Timetables.Infrastructure.Sqlite;

public sealed record SqlLiteSettings
{
	public string DirectoryName { get; init; } = string.Empty;
	public string FileName { get; init; } = string.Empty;
	public string InitFileName { get; init; } = string.Empty;
}
