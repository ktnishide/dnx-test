// Copyright (c) 2021, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:http/http.dart';
import 'package:test/test.dart';

void runTests(
  void Function(String name, Future<void> Function(String host)) testServer,
) {
  group('Test group - order controller', () {
    testServer('get ok', (host) async {
      final response = await get(Uri.parse('$host/order/'));
      expect(response.statusCode, 200);
    });

    testServer('post ok', (host) async {
      final response = await post(
        Uri.parse('$host/order/'),
        body: {
          "store_number": "1",
          "order_number": "2",
          "order_datetime": "2021-09-26T03:14:52.138946",
          "flavours": "Brown Sugar",
          "toppings": "tapioca pearls",
          "amount_of_ice": "Full",
          "total_order_price": "99.0"
        },
      );
      expect(response.statusCode, 200);
    });

    testServer('post NOK - Brown Sugar', (host) async {
      final response = await post(
        Uri.parse('$host/order/'),
        body: {
          "store_number": "1",
          "order_number": "2",
          "order_datetime": "2021-09-26T03:14:52.138946",
          "flavours": "Brown Sugar",
          "toppings": "tapioca pearls",
          "amount_of_ice": "Half",
          "total_order_price": "99.0"
        },
      );
      expect(response.statusCode, 500);
    });
    testServer('post NOK - flavour', (host) async {
      final response = await post(
        Uri.parse('$host/order/'),
        body: {
          "store_number": "1",
          "order_number": "2",
          "order_datetime": "2021-09-26T03:14:52.138946",
          "flavours": "xxx",
          "toppings": "tapioca pearls",
          "amount_of_ice": "Half",
          "total_order_price": "99.0"
        },
      );
      expect(response.statusCode, 500);
      expect(response.body, contains('flavour'));
    });
    testServer('post NOK - toppings', (host) async {
      final response = await post(
        Uri.parse('$host/order/'),
        body: {
          "store_number": "1",
          "order_number": "2",
          "order_datetime": "2021-09-26T03:14:52.138946",
          "flavours": "Brown Sugar",
          "toppings": "xxx",
          "amount_of_ice": "Half",
          "total_order_price": "99.0"
        },
      );
      expect(response.statusCode, 500);
      expect(response.body, contains('topping'));
    });

    testServer('post NOK - ice', (host) async {
      final response = await post(
        Uri.parse('$host/order/'),
        body: {
          "store_number": "1",
          "order_number": "2",
          "order_datetime": "2021-09-26T03:14:52.138946",
          "flavours": "Brown Sugar",
          "toppings": "Oreo",
          "amount_of_ice": "xxxx",
          "total_order_price": "99.0"
        },
      );
      expect(response.statusCode, 500);
      expect(response.body, contains('ice'));
    });

    testServer('404', (host) async {
      var response = await get(Uri.parse('$host/not_here'));
      expect(response.statusCode, 404);
      expect(response.body, 'Route not found');
    });
    testServer('report OK', (host) async {
      var response =
          await get(Uri.parse('$host/order/report?monthYear=2021-09'));
      expect(response.statusCode, 200);
    });
    testServer('report NOK - date', (host) async {
      var response =
          await get(Uri.parse('$host/order/report?monthYear=2021-xx'));
      expect(response.statusCode, 500);
    });
  });
}
