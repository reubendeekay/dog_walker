import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_walker/models/order_model.dart';
import 'package:dog_walker/models/owner_model.dart';
import 'package:dog_walker/models/review_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class WalkerProvider with ChangeNotifier {
  Future<List<OrderModel>> getOrders({bool? accepted}) async {
    String getParameters() {
      if (accepted != null && accepted) {
        return 'accepted';
      } else if (accepted != null && !accepted) {
        return 'rejected';
      } else {
        return 'pending';
      }
    }

    final uid = FirebaseAuth.instance.currentUser!.uid;

    final id = await FirebaseFirestore.instance
        .collection('DogWalker')
        .where('user_id', isEqualTo: uid)
        .get()
        .then((value) => value.docs.first.id);

    final orderData = await FirebaseFirestore.instance
        .collection('DogWalker')
        .doc(id)
        .collection('OwnerRequest')
        .where('status', isEqualTo: getParameters())
        .get();

    final orders =
        orderData.docs.map((doc) => OrderModel.fromJson(doc)).toList();
    List<OrderModel> finalOrders = [];
    for (OrderModel o in orders) {
      await FirebaseFirestore.instance
          .collection('DogOwner')
          .where('user_id', isEqualTo: o.userId)
          .get()
          .then((doc) {
        o.owner = OwnerModel.fromJson(doc.docs.first);
        finalOrders.add(o);
      });
    }
    notifyListeners();
    return finalOrders;
  }

  Future<void> acceptRejectOrder(String orderId, bool isAccepted) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final id = await FirebaseFirestore.instance
        .collection('DogWalker')
        .where('user_id', isEqualTo: uid)
        .get();
    return FirebaseFirestore.instance
        .collection('DogWalker')
        .doc(id.docs.first.id)
        .collection('OwnerRequest')
        .doc(orderId)
        .update({'status': isAccepted ? 'accepted' : 'rejected'});
  }

  Future<List<Map<String, dynamic>>> getWalkerRatings() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final reviewsColl = await FirebaseFirestore.instance
        .collection('DogWalker')
        .doc(uid)
        .collection('Reviews')
        .get();

    final reviews =
        reviewsColl.docs.map((e) => ReviewModel.fromJson(e)).toList();

    //Get user model for each review
    List<Map<String, dynamic>> finalReviews = [];
    for (ReviewModel r in reviews) {
      await FirebaseFirestore.instance
          .collection('DogOwner')
          .where('user_id', isEqualTo: r.userId)
          .get()
          .then((doc) {
        final owner = OwnerModel.fromJson(doc.docs.first);
        finalReviews.add({
          'review': r,
          'owner': owner,
        });
      });
    }

    return finalReviews;
  }
}
