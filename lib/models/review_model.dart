import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String? userId;
  final String? review;
  final String? rating;
  final Timestamp? date;
  final String? walkerId;
  final String? orderId;

  ReviewModel(
      {this.userId,
      this.review,
      this.rating,
      this.date,
      this.walkerId,
      this.orderId});

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'review': review,
      'rating': rating,
      'date': date,
      'walker_id': walkerId,
      'order_id': orderId,
    };
  }

  factory ReviewModel.fromJson(dynamic json) {
    return ReviewModel(
      userId: json['user_id'] as String,
      review: json['review'] as String,
      rating: json['rating'] as String,
      date: json['date'],
      walkerId: json['walker_id'] as String,
      orderId: json['order_id'] as String,
    );
  }
}
