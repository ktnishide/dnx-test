using AppDotNet.Data;
using AppDotNet.ViewModels;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddDbContext<AppDbContext>();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();
await EnsureDb(app.Services, app.Logger);

app.UseSwagger();
app.UseSwaggerUI();

app.MapGet("/v1/orders", (AppDbContext context) =>
{
    var orders = context.Orders;
    return orders is not null ? Results.Ok(orders) : Results.NotFound();
}).Produces<Orders>();

app.MapPost("/v1/orders", (AppDbContext context, CreateOrderViewModel model) =>
{
    var order = model.MapTo();
    if (!model.IsValid)
        return Results.BadRequest(model.Notifications);

    context?.Orders?.Add(order);
    context?.SaveChanges();

    return Results.Created($"/v1/orders/{order.Id}", order);
});

app.MapGet("/v1/orders/report", (AppDbContext context, string monthYear) =>
{
    var reportVM = new ReportViewModel();
    var report = reportVM.Generate(monthYear, context);
    if (!reportVM.IsValid)
        return Results.BadRequest(reportVM.Notifications);

    return report is not null ? Results.Ok(report) : Results.NoContent();
}).Produces<Report>();

app.Run();

async Task EnsureDb(IServiceProvider services, ILogger logger)
{
    using var db = services.CreateScope().ServiceProvider.GetRequiredService<AppDbContext>();
    logger.LogInformation("Ensuring database exists and is up to date at connection string ", "Data Source=app.db;Cache=Shared");
    await db.Database.MigrateAsync();
}