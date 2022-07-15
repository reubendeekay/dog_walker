import 'package:dog_walker/screens/owner/notifications/widgets/owner_notification_tile.dart';
import 'package:flutter/material.dart';

class OwnerNotificationsScreen extends StatelessWidget {
  const OwnerNotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          ...List.generate(10, (index) => const OwnerNotificationTile())
        ],
      ),
    );
  }
}
