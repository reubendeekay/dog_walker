import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_walker/models/walker_model.dart';
import 'package:dog_walker/screens/auth/splash_screen.dart';
import 'package:dog_walker/screens/owner/dashboard/map_widget.dart';
import 'package:dog_walker/screens/owner/dashboard/qr_screen.dart';
import 'package:dog_walker/screens/owner/dashboard/widgets/walker_tile.dart';
import 'package:dog_walker/screens/owner/features/favorite_walker_screen.dart';

import 'package:dog_walker/screens/owner/notifications/owner_notifications.dart';
import 'package:dog_walker/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class OwnerDashboard extends StatefulWidget {
  const OwnerDashboard({Key? key}) : super(key: key);

  @override
  State<OwnerDashboard> createState() => _OwnerDashboardState();
}

class _OwnerDashboardState extends State<OwnerDashboard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              hintText: 'Search Walker',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        actions: [
          InkWell(
              onTap: () {
                Get.to(() => const OwnerNotificationsScreen());
              },
              child: const Icon(Icons.notifications)),
          const SizedBox(
            width: 10,
          ),
          InkWell(
              onTap: () {
                Get.to(() => const FavoriteWalkerScreen());
              },
              child: const Icon(Icons.favorite)),
          const SizedBox(
            width: 10,
          ),
          InkWell(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Get.offAll(() => const SplashScreen());
              },
              child: const Icon(Icons.logout)),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: size.height * 0.35, child: const MapWidget()),
          Expanded(
            child: Stack(
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('DogWalker')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('No walkers found'));
                      }

                      return ListView(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          ...List.generate(
                            snapshot.data!.docs.length,
                            (index) => WalkerTile(
                              walker: WalkerModel.fromJson(
                                  snapshot.data!.docs[index].data()),
                            ),
                          ),
                        ],
                      );
                    }),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 15,
                  child: CustomButton(
                    text: 'Verify Walker',
                    onPressed: () {
                      Get.to(() => const QrScreen());
                    },
                    color: Colors.blue[900],
                    textColor: Colors.white,
                    margin: 50,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
