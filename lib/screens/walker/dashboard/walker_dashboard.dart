import 'package:dog_walker/models/order_model.dart';
import 'package:dog_walker/providers/auth_provider.dart';
import 'package:dog_walker/providers/walker_provider.dart';
import 'package:dog_walker/screens/auth/splash_screen.dart';
import 'package:dog_walker/screens/walker/dashboard/ratings_screen.dart';
import 'package:dog_walker/screens/walker/dashboard/requests_screen.dart';
import 'package:dog_walker/screens/walker/dashboard/widgets/owner_request_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class WalkerDashboard extends StatefulWidget {
  const WalkerDashboard({Key? key}) : super(key: key);

  @override
  State<WalkerDashboard> createState() => _WalkerDashboardState();
}

class _WalkerDashboardState extends State<WalkerDashboard> {
  @override
  Widget build(BuildContext context) {
    final walker = Provider.of<AuthProvider>(context, listen: false).walker;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.star_border_outlined),
              onPressed: () {
                Get.to(() => const WalkerRatingsScreen());
              },
            ),
            IconButton(
              icon: const Icon(Icons.people),
              onPressed: () {
                Get.to(() => const RequestsScreen());
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Get.offAll(() => const SplashScreen());
              },
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 15),
              child: Text(
                'Hellow ${walker!.name!}',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
                child: FutureBuilder<List<OrderModel>>(
                    future: Provider.of<WalkerProvider>(context, listen: false)
                        .getOrders(isDashboard: true),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.data == null) {
                        return const Center(
                          child: Text('No requests yet'),
                        );
                      }

                      if (snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('No requests yet'),
                        );
                      }
                      final data = snapshot.data!;
                      return ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          children: List.generate(
                              data.length,
                              (index) => OwnerRequestCard(
                                    order: data[index],
                                    onPressed: () {
                                      setState(() {});

                                      //Reload the Future
                                    },
                                  )));
                    }))
          ],
        ));
  }
}
