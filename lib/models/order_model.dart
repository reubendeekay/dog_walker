import 'package:dog_walker/models/owner_model.dart';

class OrderModel {
  String? orderId;
  final String? orderDate;
  final String? userId;
  final String? totalCost;
  final String? time;
  final String? date;
  final String? orderTime;
  final String? totalTime;
  final String? walkerId;
  final String? paymentStatus;
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
      this.paymentStatus = 'pending',
      this.orderTime,
      this.date,
      this.owner,
      this.time});

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'order_date': orderDate,
      'user_id': userId,
      'total_cost': totalCost,
      'order_time': orderTime,
      'walker_id': walkerId,
      'total_time': totalTime,
      'status': status,
      'paymentStatus': paymentStatus,
      'time': time,
      'date': date,
    };
  }

  factory OrderModel.fromJson(dynamic json) {
    return OrderModel(
      orderId: json['order_id'] as String,
      orderDate: json['order_date'] as String,
      userId: json['user_id'] as String,
      totalCost: json['total_cost'].toString(),
      time: json['order_time'] as String,
      walkerId: json['walker_id'] as String,
      totalTime: json['total_time'] as String,
      status: json['status'] as String,
      paymentStatus: json['paymentStatus'] as String,
      orderTime: json['time'] as String,
      date: json['date'] as String,
    );
  }
}
