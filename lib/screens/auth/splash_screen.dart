import 'package:dog_walker/constants.dart';
import 'package:dog_walker/providers/auth_provider.dart';
import 'package:dog_walker/providers/location_provider.dart';
import 'package:dog_walker/screens/auth/auth_select_screen.dart';
import 'package:dog_walker/screens/auth/login_screen.dart';
import 'package:dog_walker/screens/owner/dashboard/owner_dashboard.dart';
import 'package:dog_walker/screens/walker/dashboard/walker_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      await Provider.of<LocationProvider>(context, listen: false)
          .getCurrentLocation();
      if (FirebaseAuth.instance.currentUser != null) {
        final role = await Provider.of<AuthProvider>(context, listen: false)
            .getUserType();
        if (role == UserRole.owner) {
          Get.offAll(() => const OwnerDashboard());
        } else if (role == UserRole.walker) {
          Get.offAll(() => const WalkerDashboard());
        }
      } else {
        Get.offAll(() => const AuthSelectScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: kPrimaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text('We Care \nThe Loyalist Creature',
                  style: TextStyle(fontSize: 26, color: kSecondaryColor)),
            ),
            const Spacer(),
            Image.asset('assets/images/red_dog.png'),
          ],
        ));
  }
}
