import 'dart:io';

import 'package:dog_walker/constants.dart';
import 'package:dog_walker/models/walker_model.dart';
import 'package:dog_walker/providers/auth_provider.dart';
import 'package:dog_walker/providers/location_provider.dart';
import 'package:dog_walker/screens/auth/login_screen.dart';
import 'package:dog_walker/screens/owner/dashboard/owner_dashboard.dart';
import 'package:dog_walker/screens/walker/dashboard/walker_dashboard.dart';
import 'package:dog_walker/widgets/custom_button.dart';
import 'package:dog_walker/widgets/custom_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class WalkerSignupScreen extends StatefulWidget {
  const WalkerSignupScreen({Key? key}) : super(key: key);

  @override
  State<WalkerSignupScreen> createState() => _WalkerSignupScreenState();
}

class _WalkerSignupScreenState extends State<WalkerSignupScreen> {
  String? name,
      experience,
      hourlyRate,
      availability,
      description,
      password,
      confirmPassword,
      from,
      email,
      to,
      timing;
  int selectedAvailability = 0;
  File? profileFile;

  @override
  Widget build(BuildContext context) {
    final locData = Provider.of<LocationProvider>(context).locationData!;
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
            hintText: 'Experience',
            onChanged: (value) {
              setState(() {
                experience = value;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            hintText: 'Hourly Rate',
            onChanged: (value) {
              setState(() {
                hourlyRate = value;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          const Text('Availability'),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAvailability = 0;
                    });
                  },
                  child: radioButton('Daily', selectedAvailability == 0)),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAvailability = 1;
                    });
                  },
                  child:
                      radioButton('Span of Days', selectedAvailability == 1)),
            ],
          ),
          if (selectedAvailability == 1)
            const SizedBox(
              height: 10,
            ),
          if (selectedAvailability == 1)
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: 'From',
                    onChanged: (value) {
                      setState(() {
                        from = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomTextField(
                    hintText: 'To',
                    onChanged: (value) {
                      setState(() {
                        to = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            hintText: 'Timing',
            onChanged: (value) {
              setState(() {
                timing = value;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            hintText: 'Description',
            isInfinite: true,
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
            onPressed: () async {
              final walker = WalkerModel(
                  name: name,
                  experience: experience,
                  hourlyRate: hourlyRate,
                  description: description,
                  password: password,
                  from: selectedAvailability == 0 ? 'Daily' : from,
                  to: selectedAvailability == 0 ? 'Daily' : to,
                  long: locData.longitude,
                  lat: locData.latitude,
                  email: email,
                  enabled: true,
                  isAvailable: true,
                  ratings: 0,
                  reserved: false,
                  timing: timing,
                  userType: 'walker');
              try {
                await Provider.of<AuthProvider>(context, listen: false)
                    .register(
                        userRole: UserRole.walker,
                        walkerModel: walker,
                        profileFile: profileFile!);

                Get.offAll(() => const WalkerDashboard());
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

  Widget radioButton(String text, bool isSelected) {
    return Row(
      children: [
        Icon(
          isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isSelected ? kPrimaryColor : Colors.grey,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isSelected ? kPrimaryColor : Colors.grey,
          ),
        ),
      ],
    );
  }
}
