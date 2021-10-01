import 'dart:convert';
import 'dart:developer';

import 'dart:io';

import '../models/order.dart';
import 'package:path/path.dart' as path;

abstract class IOrdersRepository {
  List getOrders();
  void saveOrder(Order order);
}

final ordersFile = File(
    path.join(path.dirname(Platform.script.toFilePath()), 'data/orders.json'));

class OrdersRepositoryFile extends IOrdersRepository {
  var orders = [];
  OrdersRepositoryFile() {
    if (!ordersFile.existsSync()) {
      ordersFile.createSync();
      ordersFile.writeAsStringSync('[]');
    }
    var x = jsonDecode(ordersFile.readAsStringSync()) as List;
    x.forEach((element) {
      orders.add(Order.fromMapDynamic(element).toJson());
    });
    log('x');
  }

  @override
  List getOrders() {
    return jsonDecode(orders.toString());
  }

  @override
  void saveOrder(Order order) {
    orders.add(order.toJson());
    final content = orders.toString();
    log(content);
    ordersFile.writeAsStringSync(content);
  }
}
