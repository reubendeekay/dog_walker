import 'package:dog_walker/constants.dart';
import 'package:dog_walker/providers/location_provider.dart';
import 'package:dog_walker/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class AuthSelectScreen extends StatefulWidget {
  const AuthSelectScreen({Key? key}) : super(key: key);

  @override
  State<AuthSelectScreen> createState() => _AuthSelectScreenState();
}

class _AuthSelectScreenState extends State<AuthSelectScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      await Provider.of<LocationProvider>(context, listen: false)
          .getCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Login as',
                style: TextStyle(fontSize: 26, color: kSecondaryColor),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                userTypeButton(
                    title: 'Dog Owner',
                    onTap: () {
                      Get.to(() => const LoginScreen(
                            role: UserRole.owner,
                          ));
                    }),
                userTypeButton(
                    title: 'Dog Walker',
                    onTap: () {
                      Get.to(() => const LoginScreen(
                            role: UserRole.walker,
                          ));
                    }),
                userTypeButton(
                    title: 'Admin',
                    onTap: () {
                      Get.to(() => const LoginScreen(
                            role: UserRole.admin,
                          ));
                    }),
              ],
            ),
            const Spacer(),
            Image.asset('assets/images/red_dog.png'),
          ],
        ));
  }

  Widget userTypeButton({required String title, required Function onTap}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      height: 45,
      width: double.infinity,
      child: RaisedButton(
        onPressed: () {
          onTap();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: kSecondaryColor,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
