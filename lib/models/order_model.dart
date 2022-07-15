class OrderModel {
  final String? orderId;
  final String? orderDate;
  final String? userId;
  final String? totalCost;

  OrderModel({this.orderId, this.orderDate, this.userId, this.totalCost});

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'order_date': orderDate,
      'user_id': userId,
      'total_cost': totalCost,
    };
  }

  factory OrderModel.fromJson(dynamic json) {
    return OrderModel(
      orderId: json['order_id'] as String,
      orderDate: json['order_date'] as String,
      userId: json['user_id'] as String,
      totalCost: json['total_cost'] as String,
    );
  }
}
