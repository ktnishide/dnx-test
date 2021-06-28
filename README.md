Bubbletea Corp
====
Bubbletea Corp sells bubble teas. Basically their clients can go to their stores and just order them.

They sell different `Flavours` of bubble tea such as `Milk Tea`, `Premium Milk Tea`, `Lychee` and `Brown Sugar`.

Additionally, the client can customise each bubble tea by choosing the amount of `Ice` (`Full`, `Half` or `None`) and by adding multiple toppings such as `Tapioca Pearls`, `Jelly`, `Cream Top` and `Oreo`.

The only non customisable flavour is the `Brown Sugar` which must always have `Full` `Ice` and `Taopica Pearls` topping, nothing else.

Today this company have a person who registers orders manually. This worked fine in the beginning but, due to their success, this solution is making it hard to scale.

To address this, they decided to automate this process.

In order to do this, they want to build a Backend API to store the information coming from the POS systems.


## Part 1 -  Save orders

Create a REST endpoint that saves orders coming from POS.

The POS will be sending the following information:
 - store number, order number, order date time, flavours, toppings, amount of ice and the total order price.

As an Engineer, your job is to create a backend app to store this information.

PS: See the General Assumptions Section

## Part 2 - Generate a report
Bubbletea Corp has been growing A LOT since the release of their mobile app integrated with new Backend Service. 
   
Just last week, millions of bubble teas have been sold in just a couple of days. It has been hard to track the money in / money out.
   
So, the finance team decided they need to receive a monthly report to keep track of it.

The backend service must expose an endpoint that returns the total numbers of orders and sum of the order price aggregated by store for a given month. 
  
*Sample Request*:

GET /report?monthYear=2021-01

*Sample Response*:
```
{
    "stores": [
        {
            "storeNumber": "1",
            "orderPriceSum": "A$991312.20",
            "orderTotal": 11111
        },
        {
            "storeNumber": "2",
            "orderPriceSum": "A$991312.20",
            "orderTotal": 222313
        },
        {
            "storeNumber": "3",
            "orderPriceSum": "A$991312.20",
            "orderTotal": 938325
        }
    ]
}
```

PS: See the General Assumptions Section

## General Assumptions
- No need to use an external database, just hold the data in memory.
- No need to design the UI.
- Ensure the app runs in docker is accessible through port `8000`. We'll test using it.
- After you finish part 1, create a Pull Request and start part 2 from a new branch. Once you finish part 2, create another Pull Request. To summarise, we expect to have one Pull Request for each part.
