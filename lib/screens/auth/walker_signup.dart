import 'dart:io';

import 'package:dog_walker/constants.dart';
import 'package:dog_walker/models/walker_model.dart';
import 'package:dog_walker/providers/auth_provider.dart';
import 'package:dog_walker/providers/location_provider.dart';
import 'package:dog_walker/screens/auth/login_screen.dart';

import 'package:dog_walker/screens/walker/dashboard/walker_dashboard.dart';
import 'package:dog_walker/widgets/add_on_map.dart';
import 'package:dog_walker/widgets/custom_button.dart';
import 'package:dog_walker/widgets/custom_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WalkerSignupScreen extends StatefulWidget {
  const WalkerSignupScreen(
      {Key? key, this.isFacebookLogin = false, this.walker})
      : super(key: key);
  final bool isFacebookLogin;
  final WalkerModel? walker;

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
      address,
      email,
      to,
      timing;
  int selectedAvailability = 0;
  File? profileFile;
  LatLng? walkerLocation;

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
          if (!widget.isFacebookLogin)
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
          if (!widget.isFacebookLogin)
            const SizedBox(
              height: 30,
            ),
          if (!widget.isFacebookLogin)
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
          if (!widget.isFacebookLogin)
            CustomTextField(
              hintText: 'Email',
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
          if (!widget.isFacebookLogin)
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
                  child: GestureDetector(
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2050),
                      );
                      setState(() {
                        from = DateFormat('dd-MM-yyyy').format(selectedDate!);
                      });
                    },
                    child: CustomTextField(
                      isEnabled: false,
                      hintText: from ?? 'From',
                      onChanged: (value) {
                        setState(() {
                          from = value;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2050),
                      );
                      setState(() {
                        to = DateFormat('dd-MM-yyyy').format(selectedDate!);
                      });
                    },
                    child: CustomTextField(
                      hintText: to ?? 'To',
                      isEnabled: false,
                      onChanged: (value) {
                        setState(() {
                          to = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () async {
              final selectedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              setState(() {
                timing = '8:00 AM to ${selectedTime!.format(context)}';
              });
            },
            child: CustomTextField(
              hintText: timing ?? 'Timing',
              isEnabled: false,
              onChanged: (value) {
                setState(() {
                  timing = value;
                });
              },
            ),
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
          Row(
            children: [
              Text(
                address ?? 'Location',
                style: const TextStyle(fontSize: 16),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Get.to(AddOnMap(
                      onChanged: (location) {
                        setState(() {
                          walkerLocation = location;
                        });
                      },
                      addressChanged: (val) {
                        setState(() {
                          address = val.address;
                        });
                      },
                    ));
                  },
                  icon: const Icon(
                    Icons.location_history,
                    size: 30,
                  ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          if (!widget.isFacebookLogin)
            CustomTextField(
              hintText: 'Password',
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
          if (!widget.isFacebookLogin)
            const SizedBox(
              height: 10,
            ),
          if (!widget.isFacebookLogin)
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
            onPressed: walkerLocation == null ||
                    experience == null ||
                    (!widget.isFacebookLogin && profileFile == null)
                ? () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Please fill all the fields'),
                        actions: [
                          FlatButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  }
                : () async {
                    final walker = WalkerModel(
                        name: name,
                        experience: experience,
                        hourlyRate: hourlyRate,
                        description: description,
                        password: password,
                        from: selectedAvailability == 0 ? 'Daily' : from,
                        to: selectedAvailability == 0 ? 'Daily' : to,
                        long: walkerLocation!.longitude,
                        lat: walkerLocation!.latitude,
                        email: email,
                        enabled: true,
                        isAvailable: true,
                        ratings: 0,
                        reserved: false,
                        timing: timing,
                        userType: 'walker');
                    try {
                      if (!widget.isFacebookLogin) {
                        await Provider.of<AuthProvider>(context, listen: false)
                            .register(
                                userRole: UserRole.walker,
                                walkerModel: walker,
                                profileFile: profileFile!);
                      } else {
                        final fwalker = WalkerModel(
                            name: widget.walker!.name!,
                            experience: experience,
                            hourlyRate: hourlyRate,
                            description: description,
                            password: widget.walker!.password!,
                            from: selectedAvailability == 0 ? 'Daily' : from,
                            to: selectedAvailability == 0 ? 'Daily' : to,
                            long: walkerLocation!.longitude,
                            lat: walkerLocation!.latitude,
                            email: widget.walker!.email!,
                            enabled: true,
                            isAvailable: true,
                            ratings: 0,
                            reserved: false,
                            timing: timing,
                            userId: widget.walker!.userId,
                            id: widget.walker!.id,
                            image: widget.walker!.image,
                            userType: 'walker');
                        await Provider.of<AuthProvider>(context, listen: false)
                            .registerFromFacebook(
                          fwalker,
                        );
                      }

                      Get.offAll(() => const WalkerDashboard());
                    } catch (e) {
                      if (kDebugMode) {
                        print(e);
                      }
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
