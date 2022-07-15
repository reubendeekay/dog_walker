import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_walker/models/order_model.dart';
import 'package:dog_walker/models/owner_model.dart';
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
    final orderData = await FirebaseFirestore.instance
        .collection('DogWalker')
        .doc(uid)
        .collection('OwnerRequest')
        .where('status', isEqualTo: getParameters())
        .get();

    final orders =
        orderData.docs.map((doc) => OrderModel.fromJson(doc)).toList();
    List<OrderModel> finalOrders = [];
    for (OrderModel o in orders) {
      await FirebaseFirestore.instance
          .collection('DogOwner')
          .doc(o.userId)
          .get()
          .then((doc) {
        o.owner = OwnerModel.fromJson(doc);
        finalOrders.add(o);
      });
    }
    notifyListeners();
    return finalOrders;
  }

  Future<void> acceptRejectOrder(String orderId, bool isAccepted) async {
    return FirebaseFirestore.instance
        .collection('DogWalker')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('OwnerRequest')
        .doc(orderId)
        .update({'status': isAccepted ? 'accepted' : 'rejected'});
  }
}
