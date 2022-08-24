import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_walker/models/order_model.dart';
import 'package:dog_walker/providers/auth_provider.dart';
import 'package:dog_walker/providers/owner_provider.dart';
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
        actions: [
          TextButton(
              onPressed: () async {
                Provider.of<OwnerProvider>(context, listen: false)
                    .deleteAllNotifications();
              },
              child: const Text(
                'Clear All',
                style: TextStyle(color: Colors.white),
              )),
          const SizedBox(
            width: 15,
          )
        ],
      ),
      body: FutureBuilder<List<OrderModel>>(
          future: Provider.of<OwnerProvider>(context, listen: false)
              .getNotifications(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final notifications = snapshot.data!
                .where((doc) => doc.status!.toLowerCase() == 'accepted')
                .toList();
            if (notifications.isEmpty) {
              return const Center(
                child: Text('No notifications'),
              );
            }

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: List.generate(notifications.length, (index) {
                final data = notifications[index];

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
