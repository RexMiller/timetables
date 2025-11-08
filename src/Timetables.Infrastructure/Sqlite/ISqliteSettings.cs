namespace Timetables.Infrastructure.Sqlite;

public interface ISqliteSettings
{
	string DirectoryName { get; init; }
	string FileName { get; init; }
	string InitFileName { get; init; }

	string DirectoryAbsolutePath();
	string FileAbsolutePath();
}
