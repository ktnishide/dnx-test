using Flunt.Notifications;
using Flunt.Validations;

namespace AppDotNet.ViewModels
{
    public class CreateOrderViewModel : Notifiable<Notification>
    {
        private int storeNumber = 0;
        private int orderNumber = 0;
        private DateTime orderDatetime = DateTime.Now;
        private string flavour = "";
        private string toppings = "";
        private string amountOfIce = "";
        private double totalOrderPrice = 0.0;

        public int StoreNumber { get => storeNumber; set => storeNumber = value; }
        public int OrderNumber { get => orderNumber; set => orderNumber = value; }
        public DateTime OrderDatetime { get => orderDatetime; set => orderDatetime = value; }
        public string Flavor { get => flavour; set => flavour = value; }
        public string Toppings { get => toppings; set => toppings = value; }
        public string AmountOfIce { get => amountOfIce; set => amountOfIce = value; }
        public double TotalOrderPrice { get => totalOrderPrice; set => totalOrderPrice = value; }

        public Orders MapTo()
        {
            AddNotifications(new Contract<Notification>()
                .Requires()
                .IsNotNullOrEmpty(Flavor, "Flavour")
                .IsNotNullOrEmpty(Toppings, "Toppings")
                .IsNotNullOrEmpty(AmountOfIce, "Amount Of Ice")
                );

            if (!(new[] {
                "MILK TEA",
                "PREMIUM MILK TEA",
                "LYCHEE",
                "BROWN SUGAR",
             }).Contains(Flavor.Trim().ToUpper()))
            {
                AddNotification(Flavor, $"Unnexpected Flavour: {Flavor}");
            }

            List<string> toppings = Toppings.Split(",").ToList<string>();
            foreach (var item in toppings)
            {
                if (!(new[] {
                "TAPIOCA PEARLS",
                "JELLY",
                "CREAM TOP",
                "OREO",
             }).Contains(item.Trim().ToUpper()))
                {
                    AddNotification(item, $"Unnexpected Topping: {item}");
                }
            }


            //The only non customisable flavour is the Brown Sugar
            //which must always have Full Ice and Taopica Pearls topping, nothing else.
            if (Flavor.Trim().ToUpper() == "BROWN SUGAR")
            {
                if (toppings.Count() != 1 ||
                    toppings[0].Trim().ToUpper() != "TAPIOCA PEARLS" ||
                    AmountOfIce.ToUpper() != "FULL")
                {
                    AddNotification(Flavor, @"Invalid combination for Brown Sugar, expected:{Flavor: Brown Sugar,Toppings: tapioca pearls,AmountOfIce: Full}");
                }
            }

            if (!(new[] {
                "FULL",
                "HALF",
                "NONE",
             }).Contains(AmountOfIce.Trim().ToUpper()))
            {
                AddNotification(AmountOfIce, $"Unnexpected AmountOfIce: {AmountOfIce}");
            }

            return new Orders(Guid.NewGuid(), StoreNumber, OrderNumber, OrderDatetime, Flavor, Toppings, AmountOfIce, TotalOrderPrice);
        }
    }
}
