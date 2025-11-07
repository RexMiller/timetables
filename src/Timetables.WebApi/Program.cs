using Timetables.WebApi.Configuration;

namespace Timetables.WebApi;

public class Program
{
	public static void Main(string[] args)
	{
		var builder = WebApplication.CreateBuilder(args);
		builder.Services.AddControllers();
		builder.Services.AddOpenApi();

		builder.Services.ConfigureServices(builder.Configuration);

		var app = builder.Build();

		if (app.Environment.IsDevelopment())
		{
			app.MapOpenApi();
		}

		app.ConfigureDatabase();
		app.UseAuthorization();
		app.MapControllers();
		app.Run();
	}
}
