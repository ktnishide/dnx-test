import 'dart:convert';

import 'package:container_server_example/shared/helpers.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/order.dart';
import '../repositories/orders_repository.dart';

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
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }
    });

    router.get('/', (request) {
      try {
        return Response.ok(json.encode(orderRepository.getOrders()),
            headers: {'Content-Type': 'application/json'});
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }
    });

    return router;
  }
}
