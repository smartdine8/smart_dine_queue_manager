import 'package:equatable/equatable.dart';

class OrderItemModel extends Equatable {
  final String order_item_name;
  final bool is_veg;
  final int order_item_quantity;
  final int time_taken;
  final int order_item_price;

  OrderItemModel(
      {this.order_item_name = '',
        this.is_veg = false,
        this.order_item_quantity = 0,
        this.time_taken = 0,
        this.order_item_price = 0});

  factory OrderItemModel.fromMap(Map<String, dynamic> json) {
    return OrderItemModel(
        order_item_name: json["order_item_name"] ?? "",
        is_veg: json["is_veg"] ?? false,
        time_taken: json["time_taken"] ?? 0,
        order_item_quantity: json["order_item_quantity"] ?? 0,
        order_item_price: json["order_item_price"] ?? 0);
  }

  Map<String, dynamic> toMap() {
    return {
      "order_item_name": order_item_name,
      "is_veg": is_veg,
      "order_item_price": order_item_price,
      "order_item_quantity": order_item_quantity,
      "time_taken": time_taken,
    };
  }

  OrderItemModel cloneWith({
    order_item_name,
    is_veg,
    time_taken,
    order_item_price,
    order_item_quantity,
  }) {
    return OrderItemModel(
      order_item_name: order_item_name ?? this.order_item_name,
      order_item_quantity: order_item_quantity ?? this.order_item_quantity,
      is_veg: is_veg ?? this.is_veg,
      time_taken: time_taken ?? this.time_taken,
      order_item_price: order_item_price ?? this.order_item_price,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    order_item_name,
    order_item_price,
    order_item_quantity,
    time_taken,
    is_veg
  ];
}
