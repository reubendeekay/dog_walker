import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_walker/models/admin_model.dart';
import 'package:dog_walker/models/owner_model.dart';
import 'package:dog_walker/models/walker_model.dart';
import 'package:dog_walker/screens/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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
      AdminModel? adminModel,
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
      } else {
        final userCredentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: walkerModel!.email!, password: walkerModel.password!);
        await FirebaseFirestore.instance
            .collection('Admin')
            .doc(userCredentials.user!.uid)
            .set({
          'user_id': adminModel!.userId!,
          'user_type': 'admin',
          'user_name': adminModel.name!,
          'user_email': adminModel.email!,
        });
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

      if (requiredUser.docs.isEmpty) {
        print(userData.userId);
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
      if (requiredUser.docs.isEmpty) {
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
    } else {}

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

  Future<void> signInWithFacebook({
    required UserRole userRole,
  }) async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    try {
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      final userCredentials = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      try {
        if (UserRole.owner == userRole) {
          final ownerModel = OwnerModel();

          ownerModel.userId = userCredentials.user!.uid;
          ownerModel.id = userCredentials.user!.uid;

          ownerModel.image = userCredentials.user!.photoURL;
          ownerModel.name = userCredentials.user!.displayName;
          ownerModel.email = userCredentials.user!.email;
          ownerModel.userId = userCredentials.user!.uid;
          ownerModel.userType = 'owner';
          ownerModel.age = '0';
          ownerModel.description = 'Logged in from Facebook';

          await FirebaseFirestore.instance
              .collection('DogOwner')
              .doc(userCredentials.user!.uid)
              .set(ownerModel.toJson());
        } else if (UserRole.walker == userRole) {
          final walkerModel = WalkerModel();

          walkerModel.userId = userCredentials.user!.uid;
          walkerModel.id = userCredentials.user!.uid;

          walkerModel.image = userCredentials.user!.photoURL;
          walkerModel.name = userCredentials.user!.displayName;
          walkerModel.email = userCredentials.user!.email;
          walkerModel.userId = userCredentials.user!.uid;
          walkerModel.userType = 'walker';
          walkerModel.enabled = true;
          walkerModel.isAvailable = true;
          walkerModel.enabled = true;
          walkerModel.ratings = 0;

          await FirebaseFirestore.instance
              .collection('DogWalker')
              .doc(userCredentials.user!.uid)
              .set(walkerModel.toJson());
        } else {
          await FirebaseFirestore.instance
              .collection('Admin')
              .doc(userCredentials.user!.uid)
              .set({
            'user_id': userCredentials.user!.uid,
            'user_type': 'admin',
            'user_name': userCredentials.user!.displayName,
            'user_email': userCredentials.user!.email,
            'user_image': userCredentials.user!.photoURL,
          });
        }

        await getCurrentUser(userRole);

        notifyListeners();
      } catch (error) {
        throw error;
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> registerFromFacebook(WalkerModel walkerModel) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('DogWalker').doc(uid).update({
      'experience': walkerModel.experience,
      'user_hourly_rate': walkerModel.hourlyRate,
      'image': walkerModel.image,
      'lat': walkerModel.lat,
      'lng': walkerModel.long,
      'timingFrom': walkerModel.from,
      'timingTo': walkerModel.to,
      'description': walkerModel.description,
    });

    notifyListeners();
  }
}
