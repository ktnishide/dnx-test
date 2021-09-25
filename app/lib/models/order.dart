import 'dart:convert';

import 'package:collection/collection.dart';

class Order {
  int? storeNumber;
  int? orderNumber;
  DateTime? orderDatetime;
  String? flavours;
  List<String>? toppings;
  String? amountOfIce;
  double? totalOrderPrice;
  Order({
    this.storeNumber,
    this.orderNumber,
    this.orderDatetime,
    this.flavours,
    this.toppings,
    this.amountOfIce,
    this.totalOrderPrice,
  });

  Order copyWith({
    int? storeNumber,
    int? orderNumber,
    DateTime? orderDatetime,
    String? flavours,
    List<String>? toppings,
    String? amountOfIce,
    double? totalOrderPrice,
  }) {
    return Order(
      storeNumber: storeNumber ?? this.storeNumber,
      orderNumber: orderNumber ?? this.orderNumber,
      orderDatetime: orderDatetime ?? this.orderDatetime,
      flavours: flavours ?? this.flavours,
      toppings: toppings ?? this.toppings,
      amountOfIce: amountOfIce ?? this.amountOfIce,
      totalOrderPrice: totalOrderPrice ?? this.totalOrderPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'store_number': storeNumber,
      'order_number': orderNumber,
      'order_datetime': orderDatetime?.toIso8601String(),
      'flavours': flavours,
      'toppings': toppings,
      'amount_of_ice': amountOfIce,
      'total_order_price': totalOrderPrice,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      storeNumber: int.tryParse(map['store_number'] ?? '') ?? 0,
      orderNumber: int.tryParse(map['order_number'] ?? '') ?? 0,
      orderDatetime: map['order_datetime'] == null
          ? DateTime.now()
          : DateTime.tryParse(map['order_datetime']) ?? DateTime.now(),
      flavours: map['flavours'],
      toppings: List<String>.from((map['toppings'] ?? '').split(',')),
      amountOfIce: map['amount_of_ice'] ?? '',
      totalOrderPrice: double.tryParse(map['total_order_price'] ?? '') ?? 0.0,
    );
  }
  factory Order.fromMapDynamic(Map<String, dynamic> map) {
    return Order(
      storeNumber: map['store_number'] ?? 0,
      orderNumber: map['order_number'] ?? 0,
      orderDatetime: map['order_datetime'] == null
          ? DateTime.now()
          : DateTime.tryParse(map['order_datetime']) ?? DateTime.now(),
      flavours: map['flavours'],
      toppings: List.castFrom(map['toppings']),
      amountOfIce: map['amount_of_ice'] ?? '',
      totalOrderPrice: map['total_order_price'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(storeNumber: $storeNumber, orderNumber: $orderNumber, orderDatetime: $orderDatetime, flavours: $flavours, toppings: $toppings, amountOfIce: $amountOfIce, totalOrderPrice: $totalOrderPrice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Order &&
        other.storeNumber == storeNumber &&
        other.orderNumber == orderNumber &&
        other.orderDatetime == orderDatetime &&
        other.flavours == flavours &&
        listEquals(other.toppings, toppings) &&
        other.amountOfIce == amountOfIce &&
        other.totalOrderPrice == totalOrderPrice;
  }

  @override
  int get hashCode {
    return storeNumber.hashCode ^
        orderNumber.hashCode ^
        orderDatetime.hashCode ^
        flavours.hashCode ^
        toppings.hashCode ^
        amountOfIce.hashCode ^
        totalOrderPrice.hashCode;
  }

  validate() {
    if (![
      'MILK TEA',
      'PREMIUM MILK TEA',
      'LYCHEE',
      'BROWN SUGAR',
    ].contains(flavours?.trim().toUpperCase())) {
      throw 'unnexpected flavour: $flavours';
    }

    toppings?.forEach((element) {
      if (![
        'TAPIOCA PEARLS',
        'JELLY',
        'CREAM TOP',
        'OREO',
      ].contains(element.trim().toUpperCase())) {
        throw 'unnexpected toppings: ${toppings.toString()}';
      }
    });

    if (![
      'FULL',
      'HALF',
      'NONE',
    ].contains(amountOfIce?.trim().toUpperCase())) {
      throw 'unnexpected amount of ice: $amountOfIce';
    }

    //The only non customisable flavour is the Brown Sugar
    //which must always have Full Ice and Taopica Pearls topping, nothing else.
    if (flavours?.trim().toUpperCase() == 'BROWN SUGAR') {
      if (toppings?.length != 1 ||
          toppings?[0].trim().toUpperCase() != 'TAPIOCA PEARLS' ||
          amountOfIce?.toUpperCase() != 'FULL') {
        throw 'Invalid combination for Brown Sugar';
      }
    }
  }
}
