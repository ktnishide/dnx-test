import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart' as path;

import '../models/order.dart';

abstract class IOrdersRepository {
  List<Order> getOrders();
  void saveOrder(Order order);
}

final ordersFile = File(
    path.join(path.dirname(Platform.script.toFilePath()), 'data/orders.json'));

class OrdersRepositoryFile extends IOrdersRepository {
  var orders = [];
  OrdersRepositoryFile() {
    // initialize file
    if (!ordersFile.existsSync()) {
      ordersFile.createSync();
      ordersFile.writeAsStringSync('[]');
    }
    // load file orders in memory
    (jsonDecode(ordersFile.readAsStringSync()) as List).forEach(addOrders);
  }

  void addOrders(element) => orders.add(Order.fromMapDynamic(element).toJson());

  @override
  List<Order> getOrders() =>
      [...orders.map((e) => Order.fromMapDynamic(jsonDecode(e)))];

  @override
  void saveOrder(Order order) {
    orders.add(order.toJson());
    final content = orders.toString();
    ordersFile.writeAsStringSync(content);
  }
}
