import 'package:dog_walker/constants.dart';
import 'package:dog_walker/providers/auth_provider.dart';
import 'package:dog_walker/screens/auth/forgot_password_dialog.dart';
import 'package:dog_walker/screens/auth/owner_signup.dart';
import 'package:dog_walker/screens/auth/walker_signup.dart';
import 'package:dog_walker/screens/owner/dashboard/owner_dashboard.dart';
import 'package:dog_walker/screens/walker/dashboard/walker_dashboard.dart';
import 'package:dog_walker/widgets/custom_button.dart';
import 'package:dog_walker/widgets/custom_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

enum UserRole { owner, walker, admin }

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.role}) : super(key: key);
  final UserRole role;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          'Login!',
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
        const SizedBox(height: 15),
        GestureDetector(
          onTap: () {
            showForgotPasswordDialog(context);
          },
          child: Row(
            children: const [
              Spacer(),
              Text('Have you forgotten your password?')
            ],
          ),
        ),
        const SizedBox(height: 40),
        CustomButton(
          onPressed: () async {
            try {
              await Provider.of<AuthProvider>(context, listen: false)
                  .login(email!, password!, widget.role);

              if (widget.role == UserRole.owner) {
                Get.offAll(() => const OwnerDashboard());
              } else if (widget.role == UserRole.walker) {
                Get.offAll(() => const WalkerDashboard());
              } else {}
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(e.toString()),
              ));
            }
          },
          text: 'Login',
          margin: 0,
        ),
        const SizedBox(height: 40),
        Center(
          child: GestureDetector(
            child: RichText(
                text: TextSpan(text: 'I don\'t have an account? ', children: [
              TextSpan(
                  text: 'Create an account',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      if (widget.role == UserRole.owner) {
                        Get.to(() => const OwnerSignup());
                      } else if (widget.role == UserRole.walker) {
                        Get.to(() => const WalkerSignupScreen());
                      } else {}
                    },
                  style: const TextStyle(decoration: TextDecoration.underline))
            ])),
          ),
        ),
      ],
    ));
  }
}
