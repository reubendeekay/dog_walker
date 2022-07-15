import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_walker/models/owner_model.dart';
import 'package:dog_walker/models/walker_model.dart';
import 'package:dog_walker/screens/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AuthProvider with ChangeNotifier {
  OwnerModel? _owner;
  OwnerModel? get owner => _owner;
  WalkerModel? _walker;
  WalkerModel? get walker => _walker;

  //LOGIN AS AN EXISTING USER

  Future<void> login(String email, String password, UserRole userRole) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      await getCurrentUser(userRole);

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

//REGISTER AS A NEW USER
  Future<void> register(
      {required UserRole userRole,
      OwnerModel? ownerModel,
      WalkerModel? walkerModel,
      required File profileFile}) async {
    try {
      if (UserRole.owner == userRole) {
        final userCredentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: ownerModel!.email!.trim(),
                password: ownerModel.password!.trim());
        ownerModel.userId = userCredentials.user!.uid;
        ownerModel.id = userCredentials.user!.uid;

//UPLOAD PROFILE IMAGE TO STORAGE
        final ref = await FirebaseStorage.instance
            .ref('profile_images/${userCredentials.user!.uid}')
            .putFile(profileFile);
        final url = await ref.ref.getDownloadURL();

        ownerModel.image = url;

        await FirebaseFirestore.instance
            .collection('DogOwner')
            .doc(userCredentials.user!.uid)
            .set(ownerModel.toJson());
      } else if (UserRole.walker == userRole) {
        final userCredentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: walkerModel!.email!, password: walkerModel.password!);

        walkerModel.userId = userCredentials.user!.uid;
        walkerModel.id = userCredentials.user!.uid;

//UPLOAD PROFILE IMAGE TO STORAGE
        final ref = await FirebaseStorage.instance
            .ref('profile_images/${userCredentials.user!.uid}')
            .putFile(profileFile);
        final url = await ref.ref.getDownloadURL();

        walkerModel.image = url;

        await FirebaseFirestore.instance
            .collection('DogWalker')
            .doc(userCredentials.user!.uid)
            .set(walkerModel.toJson());
      }

      await getCurrentUser(userRole);

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  //GETTING CURRENT USER

  Future<void> getCurrentUser(UserRole userRole) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    if (userRole == UserRole.owner) {
      final requiredUser = await FirebaseFirestore.instance
          .collection('DogOwner')
          .where('user_id', isEqualTo: uid)
          .get();

      final userData = OwnerModel.fromJson(requiredUser.docs.first);

      if (userData.userType != 'owner') {
        Get.snackbar('UNAUTHORIZED', 'You are not registered as a dog owner',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            icon: const Icon(
              Icons.error,
              color: Colors.white,
            ));
        await FirebaseAuth.instance.signOut();
        throw Exception('You are not an owner');
      }
      _owner = userData;
    } else if (userRole == UserRole.walker) {
      final requiredUser = await FirebaseFirestore.instance
          .collection('DogWalker')
          .where('user_id', isEqualTo: uid)
          .get();

      final userData = WalkerModel.fromJson(requiredUser.docs.first);
      if (userData.userType != 'walker') {
        Get.snackbar('UNAUTHORIZED', 'You are not registered as a dog walker',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            icon: const Icon(
              Icons.error,
              color: Colors.white,
            ));
        await FirebaseAuth.instance.signOut();

        throw Exception('You are not an walker');
      }
      _walker = userData;
    }

    notifyListeners();
  }

  Future<UserRole> getUserType() async {
    try {
      await getCurrentUser(UserRole.owner);
      return UserRole.owner;
    } catch (error) {
      print(error);
      try {
        await getCurrentUser(UserRole.walker);
        return UserRole.walker;
      } catch (error) {
        print(error);

        await getCurrentUser(UserRole.admin);
        return UserRole.admin;
      }
    }
  }
}
