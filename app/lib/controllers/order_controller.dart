import 'dart:convert';
import 'dart:developer';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/order.dart';
import '../models/orders_report.dart';
import '../repositories/orders_repository.dart';
import '../shared/helpers.dart';

class OrderController {
  OrderController(this.orderRepository);
  final IOrdersRepository orderRepository;

  Router get router {
    final router = Router();

    router.post('/', (Request request) async {
      try {
        final order = Order.fromMap(await request.parse());
        order.validate();
        orderRepository.saveOrder(order);
        return Response.ok(order.toJson());
      } catch (e, stack) {
        return handleError(e, stack);
      }
    });

    router.get('/', (request) {
      try {
        return Response.ok(json.encode(orderRepository.getOrders()),
            headers: {'Content-Type': 'application/json'});
      } catch (e, stack) {
        return handleError(e, stack);
      }
    });

    router.get('/report<monthYear|.*>', (Request request) async {
      try {
        final monthYear = request.url.queryParameters['monthYear'] ?? '';
        final orders = orderRepository.getOrders();

        OrdersReport report = OrdersReport();

        return Response.ok(
            json.encode(report.generateReport(orders, monthYear).toJson()),
            headers: {'Content-Type': 'application/json'});
      } catch (e, stack) {
        return handleError(e, stack);
      }
    });

    return router;
  }

  Response handleError(e, stack) {
    log(e.toString());
    log(stack.toString());
    return Response.internalServerError(body: e.toString());
  }
}
