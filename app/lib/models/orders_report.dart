import "package:collection/collection.dart";

import 'order.dart';

class OrdersReport {
  List<Stores>? stores;

  OrdersReport({this.stores});

  OrdersReport.fromJson(Map<String, dynamic> json) {
    if (json['stores'] != null) {
      stores = <Stores>[];
      json['stores'].forEach((v) {
        stores?.add(Stores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (stores != null) {
      data['stores'] = stores!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  OrdersReport generateReport(List<Order> orders, String monthYear) {
    final storesByMonth = filterByMonth(orders, monthYear);
    return groupAndSumByStore(storesByMonth, 'store_number');
  }

  filterByMonth(List<Order> orders, String monthYear) {
    final searchDate = DateTime.tryParse('$monthYear-01');
    if (searchDate == null) {
      throw 'Invalid period: $monthYear, expected: YYYY-MM';
    }
    return orders
        .where((element) =>
            element.orderDatetime?.year == searchDate.year &&
            element.orderDatetime?.month == searchDate.month)
        .toList();
  }

  groupAndSumByStore(List<Order> storesByMonth, String key) {
    Map groupByStore =
        groupBy(storesByMonth.map((e) => e.toMap()), (Map obj) => obj[key]);
    var report = OrdersReport(stores: []);

    groupByStore.forEach((k, v) {
      report.stores!.add(Stores(
        storeNumber: k.toString(),
        orderPriceSum:
            'A\$${(v.fold(0, (prev, element) => prev + element['total_order_price']) as double).toStringAsFixed(2)}',
        orderTotal: v.fold(0, (prev, element) => prev + 1),
      ));
    });

    return report;
  }

  @override
  String toString() => 'OrdersReport(stores: $stores)';
}

class Stores {
  String? storeNumber;
  String? orderPriceSum;
  int? orderTotal;

  Stores({this.storeNumber, this.orderPriceSum, this.orderTotal});

  Stores.fromJson(Map<String, dynamic> json) {
    storeNumber = json['storeNumber'];
    orderPriceSum = json['orderPriceSum'];
    orderTotal = json['orderTotal'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['storeNumber'] = storeNumber;
    data['orderPriceSum'] = orderPriceSum;
    data['orderTotal'] = orderTotal;
    return data;
  }

  @override
  String toString() =>
      'Stores(storeNumber: $storeNumber, orderPriceSum: $orderPriceSum, orderTotal: $orderTotal)';
}
