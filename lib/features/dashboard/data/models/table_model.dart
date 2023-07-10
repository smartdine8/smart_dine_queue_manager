// To parse this JSON data, do
//
//     final tableModel = tableModelFromJson(jsonString);

import 'dart:convert';

TableModel tableModelFromJson(String str) => TableModel.fromJson(json.decode(str));

String tableModelToJson(TableModel data) => json.encode(data.toJson());

class TableModel {
  bool? isBillPaid;
  bool? isOrderPlaced;
  bool? isOccupied;
  String? tableId;
  String? tableName;
  String? time;
  String? totalCapacity;
  String? customerName;
  String? customerPeopleCount;

  TableModel({
    this.isBillPaid,
    this.isOrderPlaced,
    this.isOccupied,
    this.tableId,
    this.tableName,
    this.time,
    this.totalCapacity,
    this.customerName,
    this.customerPeopleCount,
  });

  TableModel copyWith({
    bool? isBillPaid,
    bool? isCombined,
    bool? isOrderPlaced,
    bool? isOccupied,
    String? tableId,
    String? tableName,
    String? time,
    String? totalCapacity,
    String? customerName,
    String? customerPeopleCount,
  }) =>
      TableModel(
        isBillPaid: isBillPaid ?? this.isBillPaid,
        isOrderPlaced: isOrderPlaced ?? this.isOrderPlaced,
        isOccupied: isOccupied ?? this.isOccupied,
        tableId: tableId ?? this.tableId,
        tableName: tableName ?? this.tableName,
        time: time ?? this.time,
        totalCapacity: totalCapacity ?? this.totalCapacity,
        customerName: customerName ?? this.customerName,
        customerPeopleCount: customerPeopleCount ?? this.customerPeopleCount,
      );

  factory TableModel.fromJson(dynamic json) => TableModel(
    isBillPaid: json["is_bill_paid"],
    isOrderPlaced: json["is_order_placed"],
    isOccupied: json["is_occupied"],
    tableId: json["table_id"],
    tableName: json["table_name"],
    time: json["time"],
    totalCapacity: json["total_capacity"],
    customerName: json["customer_name"],
    customerPeopleCount: json["customer_people_count"],
  );

  Map<String, dynamic> toJson() => {
    "is_bill_paid": isBillPaid,
    "is_order_placed": isOrderPlaced,
    "is_occupied": isOccupied,
    "table_id": tableId,
    "table_name": tableName,
    "time": time,
    "total_capacity": totalCapacity,
    "customer_name": customerName,
    "customer_people_count": customerPeopleCount,
  };
}
