using experiment;
using experiment.Services;
using Microsoft.EntityFrameworkCore;
using Prometheus;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
var connectionString = GetConnectionString();

builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseNpgsql(connectionString));

builder.Services.AddOpenApi();

builder.Services.AddScoped<TestService>();

builder.Services.AddControllers();


var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

app.UseRouting();

app.UseHttpMetrics();
app.MapMetrics();

app.UseHttpsRedirection();

app.MapControllers();

app.Run();

static void Main()
{
    
}

static String GetConnectionString()
{
    var dbHost = Environment.GetEnvironmentVariable("DB_HOST") ?? "localhost";
    var dbPort = Environment.GetEnvironmentVariable("DB_PORT") ?? "6543";
    var dbName = Environment.GetEnvironmentVariable("DB_NAME") ?? "experiment";
    var dbUser = Environment.GetEnvironmentVariable("DB_USERNAME") ?? "admin";
    var dbPassword = Environment.GetEnvironmentVariable("DB_PASSWORD") ?? "admin";

    return $"Host={dbHost};Port={dbPort};Database={dbName};Username={dbUser};Password={dbPassword}";
}