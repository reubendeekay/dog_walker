import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_walker/models/order_model.dart';
import 'package:dog_walker/providers/auth_provider.dart';
import 'package:dog_walker/screens/owner/notifications/widgets/owner_notification_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OwnerNotificationsScreen extends StatelessWidget {
  const OwnerNotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final owner = Provider.of<AuthProvider>(context, listen: false).owner;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .where('user_id', isEqualTo: uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No notifications'),
              );
            }

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: List.generate(snapshot.data!.docs.length, (index) {
                final data = OrderModel.fromJson(snapshot.data!.docs[index]);

                data.owner = owner;
                return OwnerNotificationTile(
                  order: data,
                );
              }),
            );
          }),
    );
  }
}
