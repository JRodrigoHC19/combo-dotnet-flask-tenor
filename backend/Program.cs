using System.Text.Json;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddHttpClient();

builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(builder =>
    {
        builder.AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod();
    });
});

var app = builder.Build();

app.UseCors();

app.MapGet("/search", async (HttpClient client, int limit = 8) =>
{
    var response = await client.GetStringAsync($"https://g.tenor.com/v1/search?&key=LIVDSRZULELA&limit={limit}");
    var res_json = JsonSerializer.Deserialize<object>(response);
    return Results.Json(res_json);
});

app.Run();