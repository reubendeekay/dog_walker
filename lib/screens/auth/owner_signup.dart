import 'dart:io';

import 'package:dog_walker/constants.dart';
import 'package:dog_walker/models/owner_model.dart';
import 'package:dog_walker/providers/auth_provider.dart';
import 'package:dog_walker/screens/auth/login_screen.dart';
import 'package:dog_walker/screens/owner/dashboard/owner_dashboard.dart';
import 'package:dog_walker/widgets/custom_button.dart';
import 'package:dog_walker/widgets/custom_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class OwnerSignup extends StatefulWidget {
  const OwnerSignup({Key? key}) : super(key: key);

  @override
  State<OwnerSignup> createState() => _OwnerSignupState();
}

class _OwnerSignupState extends State<OwnerSignup> {
  String? name, email, age, password, description, confirmPassword, address;
  File? profileFile;

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
            child: GestureDetector(
              onTap: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles(allowMultiple: false);

                if (result != null) {
                  profileFile = File(result.files.single.path!);
                  setState(() {});
                } else {
                  // User canceled the picker
                }
              },
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        profileFile == null ? null : FileImage(profileFile!),
                  ),
                  const Positioned(
                      bottom: 0,
                      right: 0,
                      child: Icon(Icons.camera_alt_rounded)),
                ],
              ),
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
            onPressed: profileFile == null
                ? null
                : () async {
                    final owner = OwnerModel(
                      name: name,
                      email: email,
                      age: age,
                      address: address,
                      description: description,
                      password: password,
                      enabled: true,
                      userType: 'owner',
                    );
                    try {
                      await Provider.of<AuthProvider>(context, listen: false)
                          .register(
                              userRole: UserRole.owner,
                              ownerModel: owner,
                              profileFile: profileFile!);

                      Get.offAll(() => const OwnerDashboard());
                    } catch (e) {
                      print(e);
                    }
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
