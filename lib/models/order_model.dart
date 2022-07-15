import 'package:dog_walker/models/owner_model.dart';

class OrderModel {
  String? orderId;
  final String? orderDate;
  final String? userId;
  final String? totalCost;
  final String? time;
  final String? totalTime;
  final String? walkerId;
  final String? status;
  OwnerModel? owner;

  OrderModel(
      {this.orderId,
      this.orderDate,
      this.userId,
      this.totalCost,
      this.walkerId,
      this.totalTime,
      this.status = 'pending',
      this.owner,
      this.time});

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'order_date': orderDate,
      'user_id': userId,
      'total_cost': totalCost,
      'order_time': time,
      'walker_id': walkerId,
      'total_time': totalTime,
      'status': status,
    };
  }

  factory OrderModel.fromJson(dynamic json) {
    return OrderModel(
      orderId: json['order_id'] as String,
      orderDate: json['order_date'] as String,
      userId: json['user_id'] as String,
      totalCost: json['total_cost'] as String,
      time: json['order_time'] as String,
      walkerId: json['walker_id'] as String,
      totalTime: json['total_time'] as String,
      status: json['status'] as String,
    );
  }
}
