using System.Text.RegularExpressions;
using AppDotNet.Data;
using Flunt.Notifications;
using Flunt.Validations;

namespace AppDotNet.ViewModels
{
    public class ReportViewModel : Notifiable<Notification>
    {
        public dynamic? Generate(string? monthYear, AppDbContext db)
        {
            AddNotifications(new Contract<Notification>()
                .Requires()
                .IsNotNullOrEmpty(monthYear, "monthYear")
                .Matches(monthYear, @"^\d{4}-\d{2}$", "monthYear")
                );

            DateTime iDateTime;
            if (!DateTime.TryParse($"{monthYear}-01", out iDateTime))
            {
                AddNotification(monthYear, $"Unnexpected monthYear: {monthYear}, expected: YYYY-MM");
                return null;
            }
            DateTime fDateTime = iDateTime.AddMonths(1);



            var orders = db.Orders?
            .Where(o => o.OrderDatetime >= iDateTime && o.OrderDatetime < fDateTime)
            .GroupBy(orders => orders.StoreNumber)
            .Select(ordersGroup => new
            Store(
                 ordersGroup.Key.ToString(),
                 ordersGroup.Sum(t => t.TotalOrderPrice).ToString("A$0.00"),
                 ordersGroup.Count()
            )).ToList()
            ;

            if (!orders!.Any())
            {
                AddNotification("orders", "No orders found");
                return null;
            }

            return new Report(orders);
        }
    }
}
