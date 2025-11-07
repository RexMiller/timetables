using Dapper;
using Microsoft.Data.Sqlite;

namespace Timetables.Infrastructure.Sqlite;

public sealed class DatabaseInitializer
{
	private readonly ConnectionStringFactory _conStringFactory;
	private readonly SqlLiteSettings _settings;

	public DatabaseInitializer(ConnectionStringFactory conStringFactory, SqlLiteSettings settings)
	{
		_conStringFactory = conStringFactory;
		_settings = settings;
	}

	public void Initialize()
	{
		var conStr = _conStringFactory.Create();
		using var con = new SqliteConnection(conStr);

		var initFilePath = Path.Combine(_conStringFactory.DirectoryAbsolutePath(), $"{_settings.InitFileName}.sql");

		initFilePath = File.Exists(initFilePath)
			? initFilePath
			: Path.Combine(_conStringFactory.DirectoryAbsolutePath(), $"{_settings.InitFileName}.txt");

		var sql = File.ReadAllText(initFilePath);

		con.Open();
		con.Execute(sql);
		con.Close();
	}
}
