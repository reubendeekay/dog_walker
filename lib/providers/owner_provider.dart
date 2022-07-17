import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_walker/models/order_model.dart';
import 'package:dog_walker/models/review_model.dart';
import 'package:dog_walker/models/walker_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class OwnerProvider with ChangeNotifier {
  Future<List<WalkerModel>> getAllWalkers() async {
    final walkerData =
        await FirebaseFirestore.instance.collection('DogWalker').get();

    return walkerData.docs.map((doc) => WalkerModel.fromJson(doc)).toList();
  }

  Future<void> requestWalker(OrderModel order) async {
    final user_Id = await FirebaseFirestore.instance
        .collection('DogWalker')
        .where('user_id', isEqualTo: order.walkerId)
        .get()
        .then((value) => value.docs.first.id);
    final ref = FirebaseFirestore.instance
        .collection('DogWalker')
        .doc(user_Id)
        .collection('OwnerRequest');
    final id = ref.id;
    order.orderId = id;

    await FirebaseFirestore.instance
        .collection('orders')
        .doc(id)
        .set(order.toJson());

    await ref.doc(id).set(order.toJson());
  }

  Future<void> getNotifications() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final userId = await FirebaseFirestore.instance
        .collection('DogOwner')
        .where('user_id', isEqualTo: uid)
        .get()
        .then((value) => value.docs.first.id);
    final ref = FirebaseFirestore.instance
        .collection('DogOwner')
        .doc(userId)
        .collection('WalkerAccepted');
    final data = await ref.where('status', isEqualTo: 'paid').get();
  }

  Future<void> payForWalker(OrderModel order) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final userId = await FirebaseFirestore.instance
        .collection('DogOwner')
        .where('user_id', isEqualTo: uid)
        .get()
        .then((value) => value.docs.first.id);
    await FirebaseFirestore.instance
        .collection('DogOwner')
        .doc(userId)
        .collection('WalkerAccepted')
        .doc(order.orderId)
        .update({
      'status': 'paid',
    });

    await FirebaseFirestore.instance
        .collection('orders')
        .doc(order.orderId)
        .update({
      'status': 'paid',
    });
    notifyListeners();
  }

  Future<void> sendReview(ReviewModel review) async {
    final userId = await FirebaseFirestore.instance
        .collection('DogWalker')
        .where('user_id', isEqualTo: review.walkerId)
        .get()
        .then((value) => value.docs.first.id);
    await FirebaseFirestore.instance
        .collection('DogWalker')
        .doc(userId)
        .collection('Reviews')
        .doc(review.orderId)
        .set(review.toJson());
    notifyListeners();
  }

  Future<Map<String, dynamic>> verifyWalker(String orderId) async {
    final orderData = await FirebaseFirestore.instance
        .collection('orders')
        .doc(orderId)
        .get();
    final order = OrderModel.fromJson(orderData);
    final walkerId = await FirebaseFirestore.instance
        .collection('DogWalker')
        .where('user_id', isEqualTo: order.walkerId)
        .get()
        .then((value) => value.docs.first.id);
    final walkerData = await FirebaseFirestore.instance
        .collection('DogWalker')
        .doc(walkerId)
        .get();

    final walker = WalkerModel.fromJson(walkerData);
    notifyListeners();

    return {
      'walker': walker,
      'order': order,
    };
  }
}
