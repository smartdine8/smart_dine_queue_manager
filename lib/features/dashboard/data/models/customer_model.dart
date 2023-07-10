// To parse this JSON data, do
//
//     final customerModel = customerModelFromJson(jsonString);

import 'dart:convert';

CustomerModel customerModelFromJson(String str) => CustomerModel.fromJson(json.decode(str));

String customerModelToJson(CustomerModel data) => json.encode(data.toJson());

class CustomerModel {
  String? customerId;
  String? customerMobile;
  String? customerName;
  String? customerPeopleCount;
  String? customerRegisteredAt;
  bool? isVisiting;
  String? createdAt;

  CustomerModel({
    this.customerId,
    this.customerMobile,
    this.customerName,
    this.customerPeopleCount,
    this.customerRegisteredAt,
    this.isVisiting,
    this.createdAt
  });

  CustomerModel copyWith({
    String? customerId,
    String? customerMobile,
    String? customerName,
    String? customerPeopleCount,
    String? customerRegisteredAt,
    bool? isVisiting,
  }) =>
      CustomerModel(
        customerId: customerId ?? this.customerId,
        customerMobile: customerMobile ?? this.customerMobile,
        customerName: customerName ?? this.customerName,
        customerPeopleCount: customerPeopleCount ?? this.customerPeopleCount,
        customerRegisteredAt: customerRegisteredAt ?? this.customerRegisteredAt,
        isVisiting: isVisiting ?? this.isVisiting,
      );

  factory CustomerModel.fromJson(dynamic json) => CustomerModel(
    customerId: json["customer_id"],
    customerMobile: json["customer_mobile"],
    customerName: json["customer_name"],
    customerPeopleCount: json["customer_people_count"],
    customerRegisteredAt: json["customer_registered_at"],
    isVisiting: json["is_visiting"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "customer_id": customerId,
    "customer_mobile": customerMobile,
    "customer_name": customerName,
    "customer_people_count": customerPeopleCount,
    "customer_registered_at": customerRegisteredAt,
    "is_visiting": isVisiting,
    "created_at": createdAt,
  };
}
