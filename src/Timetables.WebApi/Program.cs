using Timetables.WebApi.Configuration;

namespace Timetables.WebApi;

public class Program
{
	public static async Task Main(string[] args)
	{
		var builder = WebApplication.CreateBuilder(args);
		builder.Services.AddControllers();
		builder.Services.AddOpenApi();

		builder.Services.ConfigureServices(builder.Configuration);

		var app = builder.Build();

		app.MapStaticAssets().ShortCircuit();
		app.UseFileServer();

		app.ConfigureDatabase();
		app.UseAuthorization();
		app.MapControllers();
		await app.RunAsync($"http://*:5000");
	}
}
