import 'package:dog_walker/constants.dart';
import 'package:dog_walker/screens/auth/auth_select_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => const AuthSelectScreen());
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
