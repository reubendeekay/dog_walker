import 'package:dog_walker/constants.dart';
import 'package:dog_walker/screens/owner/dashboard/owner_dashboard.dart';
import 'package:dog_walker/widgets/custom_button.dart';
import 'package:dog_walker/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class OwnerSignup extends StatefulWidget {
  const OwnerSignup({Key? key}) : super(key: key);

  @override
  State<OwnerSignup> createState() => _OwnerSignupState();
}

class _OwnerSignupState extends State<OwnerSignup> {
  String? name, email, age, password, description, confirmPassword, address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(
            horizontal: 15, vertical: kToolbarHeight),
        children: [
          const SizedBox(
            height: 20,
          ),
          Text('Lets Go!!\nFill in your details to get started.',
              style: TextStyle(fontSize: 20, color: kPrimaryColor)),
          const SizedBox(height: 40),
          Center(
            child: Stack(
              children: const [
                CircleAvatar(
                  radius: 40,
                ),
                Positioned(
                    bottom: 0, right: 0, child: Icon(Icons.camera_alt_rounded)),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          CustomTextField(
            hintText: 'Name',
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            hintText: 'Email',
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            hintText: 'Age',
            onChanged: (value) {
              setState(() {
                age = value;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            hintText: 'Address',
            onChanged: (value) {
              setState(() {
                address = value;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            hintText: 'Description',
            onChanged: (value) {
              setState(() {
                description = value;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            hintText: 'Password',
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            hintText: 'Repassword',
            onChanged: (value) {
              setState(() {
                confirmPassword = value;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomButton(
            onPressed: () {
              Get.to(() => const OwnerDashboard());
            },
            text: 'REGISTER',
            textColor: Colors.white,
            margin: 0,
          )
        ],
      ),
    );
  }
}
