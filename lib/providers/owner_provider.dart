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
    final id = ref.doc().id;
    order.orderId = id;

    await FirebaseFirestore.instance
        .collection('orders')
        .doc(id)
        .set(order.toJson());

    await ref.doc(id).set(order.toJson());
  }

  Future<List<OrderModel>> getNotifications() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final nots = await FirebaseFirestore.instance.collection('DogWalker').get();

    final List<OrderModel> notifications = [];

    for (var doc in nots.docs) {
      final notis = await FirebaseFirestore.instance
          .collection('DogWalker')
          .doc(doc.id)
          .collection('OwnerRequest')
          .where('user_id', isEqualTo: uid)
          .get();
      print(notis.docs.length);
      for (var docu in notis.docs) {
        notifications.add(OrderModel.fromJson(docu));
      }
    }
    return notifications;
  }

  Future<void> payForWalker(OrderModel order) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final walkerCollection = await FirebaseFirestore.instance
        .collection('DogWalker')
        .where('user_id', isEqualTo: order.walkerId)
        .get();

    walkerCollection.docs.first.reference
        .collection('OwnerRequest')
        .where('order_id', isEqualTo: order.orderId)
        .get()
        .then((value) {
      value.docs.first.reference.update({
        'status': 'paid',
        'paymentStatus': 'paid',
      });
    });

    await FirebaseFirestore.instance
        .collection('orders')
        .doc(order.orderId)
        .update({
      'status': 'paid',
      'paymentStatus': 'paid',
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

    final walkData = await FirebaseFirestore.instance
        .collection('DogWalker')
        .doc(userId)
        .get();

    final initialRating = walkData['rating'];
    final newRating = (double.parse(initialRating.toString()) +
            double.parse(review.rating!)) /
        (2);
    await FirebaseFirestore.instance
        .collection('DogWalker')
        .doc(userId)
        .update({
      'rating': newRating,
    });

    notifyListeners();
  }

  Future<Map<String, dynamic>?> verifyWalker(String orderId) async {
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
    if (order.status == 'paid') {
      return {
        'walker': walker,
        'order': order,
      };
    } else {
      return null;
    }
  }

  Future<List<WalkerModel>> searchWalker(
      String searchTerm, bool price, bool rating) async {
    final walkerData =
        await FirebaseFirestore.instance.collection('DogWalker').get();

    final walkerList =
        walkerData.docs.map((doc) => WalkerModel.fromJson(doc)).toList();

    final searchedWalkers = walkerList
        .where((element) =>
            element.name!.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();
    //sort by price from low to high
    if (price) {
      searchedWalkers.sort((a, b) =>
          double.parse(a.hourlyRate!).compareTo(double.parse(b.hourlyRate!)));
    }

    ///sort by rating from high to low
    if (rating) {
      searchedWalkers.sort((a, b) => b.ratings!.compareTo(a.ratings!));
    }
    return searchedWalkers;
  }

  Future<void> deleteAllNotifications() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final notData = await FirebaseFirestore.instance
        .collection('orders')
        .where('user_id', isEqualTo: uid)
        .get();

    for (var doc in notData.docs) {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(doc.id)
          .delete();
    }
    notifyListeners();
  }

  Future<List<WalkerModel>> filterResults(bool price, bool rating) async {
    final walkData = await FirebaseFirestore.instance
        .collection('DogWalker')
        .orderBy('user_hourly_rate', descending: !price)
        .get();

    // //sort by rating
    if (rating) {
      walkData.docs
          .sort((a, b) => b.data()['rating'].compareTo(a.data()['rating']));
    }

    notifyListeners();
    return walkData.docs.map((doc) => WalkerModel.fromJson(doc)).toList();
  }

  Future<void> rateWalker(ReviewModel review) async {
    final userId = await FirebaseFirestore.instance
        .collection('DogWalker')
        .where('user_id', isEqualTo: review.walkerId)
        .get()
        .then((value) => value.docs.first.id);
    await FirebaseFirestore.instance
        .collection('DogWalker')
        .doc(userId)
        .collection('Reviews')
        .doc()
        .set(review.toJson());

    final walkData = await FirebaseFirestore.instance
        .collection('DogWalker')
        .doc(userId)
        .get();

    final initialRating = walkData['rating'];
    final newRating = (double.parse(initialRating.toString()) +
            double.parse(review.rating!)) /
        (2);
    await FirebaseFirestore.instance
        .collection('DogWalker')
        .doc(userId)
        .update({
      'rating': newRating,
    });

    notifyListeners();
  }
}
