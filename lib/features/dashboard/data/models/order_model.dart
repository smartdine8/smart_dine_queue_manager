import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'order_item_model.dart';

class OrderModel extends Equatable {
  final String order_delivered_by;
  final bool is_delivered;
  final String order_id;
  final int total_time_taken;
  List<OrderItemModel>? items = [];
  final int total_amount;
  final String table_name;
  final String table_id;
  final DateTime? orderPlaceAt;

  OrderModel(
      {this.order_delivered_by = '',
        this.is_delivered = false,
        this.order_id = '',
        this.total_time_taken = 0,
        this.items,
        this.total_amount = 0,
        this.table_id = '',
        this.table_name = '',
        this.orderPlaceAt});

  factory OrderModel.fromMap(dynamic json) {
    List<OrderItemModel> OrderItemModelList = [];
    if (json["items"] != null) {
      json["items"].forEach((orderedItem) {
        return OrderItemModelList.add(OrderItemModel.fromMap(orderedItem));
      });
    }
    Timestamp firebaseTimestamp = json['order_placed_at'];

    DateTime parsedDate = firebaseTimestamp.toDate();
    return OrderModel(
        items: OrderItemModelList,
        order_delivered_by: json["order_delivered_by"] ?? "",
        is_delivered: json["is_delivered"] ?? false,
        total_time_taken: json["total_time_taken"] ?? 0,
        order_id: json["order_id"] ?? '',
        total_amount: json["total_amount"] ?? 0,
        table_id: json["table_id"] ?? "",
        table_name: json["table_name"] ?? "",
        orderPlaceAt:
        json['order_placed_at'] != null ? parsedDate : DateTime.now());
  }

  Map<String, dynamic> toMap() {
    var OrderItemModelList = items as List<OrderItemModel>;
    return {
      "items": List<dynamic>.from(
          OrderItemModelList.map((orderedItem) => orderedItem.toMap())),
      "order_delivered_by": order_delivered_by,
      "is_delivered": is_delivered,
      "total_amount": total_amount,
      "order_id": order_id,
      "total_time_taken": total_time_taken,
      "table_name": table_name,
      "table_id": table_id,
      'order_placed_at': orderPlaceAt
    };
  }

  OrderModel cloneWith(
      {order_delivered_by,
        is_delivered,
        total_time_taken,
        total_amount,
        items,
        order_id,
        table_id,
        orderPlaceAt}) {
    return OrderModel(
        order_delivered_by: order_delivered_by ?? this.order_delivered_by,
        order_id: order_id ?? this.order_id,
        is_delivered: is_delivered ?? this.is_delivered,
        total_time_taken: total_time_taken ?? this.total_time_taken,
        total_amount: total_amount ?? this.total_amount,
        items: items ?? this.items,
        table_name: table_name ?? this.table_name,
        table_id: table_id ?? this.table_id,
        orderPlaceAt: orderPlaceAt ?? this.orderPlaceAt);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    table_id,
    table_name,
    is_delivered,
    order_delivered_by,
    order_id,
    items,
    total_amount,
    total_time_taken,
    orderPlaceAt
  ];
}
