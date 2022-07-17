import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AdminProvider with ChangeNotifier {
  Future<void> toggleEnable(bool enable, bool isWalker, String uid) async {
    if (isWalker) {
      final userData = await FirebaseFirestore.instance
          .collection('DogWalker')
          .where('user_id', isEqualTo: uid)
          .get();

      await FirebaseFirestore.instance
          .collection('DogWalker')
          .doc(userData.docs.first.id)
          .update({'isEnabled': enable});
    } else {
      final userData = await FirebaseFirestore.instance
          .collection('DogOwner')
          .where('user_id', isEqualTo: uid)
          .get();

      await FirebaseFirestore.instance
          .collection('DogOwner')
          .doc(userData.docs.first.id)
          .update({'isEnabled': enable});
    }

    print('DONE');
    notifyListeners();
  }

  Future<void> toggleReserved(bool reserved, String uid) async {
    final userData = await FirebaseFirestore.instance
        .collection('DogWalker')
        .where('user_id', isEqualTo: uid)
        .get();

    await FirebaseFirestore.instance
        .collection('DogWalker')
        .doc(userData.docs.first.id)
        .update({'isReserved': reserved});

    notifyListeners();
  }
}
