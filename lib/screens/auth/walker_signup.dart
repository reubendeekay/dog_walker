import 'package:dog_walker/constants.dart';
import 'package:dog_walker/screens/owner/dashboard/owner_dashboard.dart';
import 'package:dog_walker/screens/walker/dashboard/walker_dashboard.dart';
import 'package:dog_walker/widgets/custom_button.dart';
import 'package:dog_walker/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

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
      to,
      address;
  int selectedAvailability = 0;

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
              Get.to(() => const WalkerDashboard());
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
