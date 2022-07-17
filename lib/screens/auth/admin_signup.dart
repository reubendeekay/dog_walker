import 'dart:io';

import 'package:dog_walker/constants.dart';
import 'package:dog_walker/models/admin_model.dart';
import 'package:dog_walker/providers/auth_provider.dart';
import 'package:dog_walker/screens/admin/admin_dashboard.dart';
import 'package:dog_walker/screens/auth/forgot_password_dialog.dart';
import 'package:dog_walker/screens/auth/login_screen.dart';
import 'package:dog_walker/widgets/custom_button.dart';
import 'package:dog_walker/widgets/custom_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class AdminSignup extends StatefulWidget {
  const AdminSignup({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminSignup> createState() => _AdminSignupState();
}

class _AdminSignupState extends State<AdminSignup> {
  String? email, password;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        SizedBox(
          height: size.height * 0.1 + kToolbarHeight,
        ),
        Text(
          ' Register as an Admin!',
          style: TextStyle(fontSize: 26, color: kPrimaryColor),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Fill in your details to get started.',
        ),
        SizedBox(height: size.height * 0.1),
        CustomTextField(
            hintText: 'Mail',
            onChanged: (value) {
              setState(() {
                email = value;
              });
            }),
        const SizedBox(height: 15),
        CustomTextField(
            hintText: 'Password',
            onChanged: (value) {
              setState(() {
                password = value;
              });
            }),
        const SizedBox(height: 40),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                onPressed: () async {
                  try {
                    File? file;

                    final admin = AdminModel(
                      email: email,
                      password: password,
                    );
                    await Provider.of<AuthProvider>(context, listen: false)
                        .register(
                            userRole: UserRole.admin,
                            profileFile: file!,
                            adminModel: admin);

                    Get.offAll(() => const AdminDashboard());
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(e.toString()),
                    ));
                  }
                },
                text: 'REGISTER',
                margin: 0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        Center(
          child: GestureDetector(
            child: RichText(
                text: TextSpan(text: 'Already have an account? ', children: [
              TextSpan(
                  text: 'Login',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pop();
                    },
                  style: const TextStyle(decoration: TextDecoration.underline))
            ])),
          ),
        ),
      ],
    ));
  }
}
