// Report myDeserializedClass = JsonConvert.DeserializeObject<Report>(myJsonResponse); 
    public class Store
    {
    public Store(string? storeNumber, string? orderPriceSum, int orderTotal)
    {
        this.storeNumber = storeNumber;
        this.orderPriceSum = orderPriceSum;
        this.orderTotal = orderTotal;
    }

    public string? storeNumber { get; set; }
        public string? orderPriceSum { get; set; }
        public int orderTotal { get; set; }
    }

    public class Report
    {
    public Report(List<Store>? stores)
    {
        this.stores = stores;
    }

    public List<Store>? stores { get; set; }
    }

