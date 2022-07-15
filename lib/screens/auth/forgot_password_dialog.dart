import 'package:dog_walker/constants.dart';
import 'package:dog_walker/widgets/custom_button.dart';
import 'package:dog_walker/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void showForgotPasswordDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (ctx) => Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: const ForgotPasswordDialog(),
          ));
}

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  String? email;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: kSecondaryColor.withOpacity(0.2),
                        shape: BoxShape.circle),
                    child: Icon(Icons.close, color: kSecondaryColor),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Have you forgotten\nyour password?',
              style: TextStyle(fontSize: 20, color: kSecondaryColor),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Don\'t worry, write the below detail and we will notify you regarding your password.',
              style: TextStyle(color: kSecondaryColor),
            ),
            const SizedBox(
              height: 40,
            ),
            CustomTextField(
                hintText: 'Mail',
                fillColor: kSecondaryColor.withOpacity(0.1),
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                }),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
                onPressed: () async {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: email!);
                },
                margin: 0,
                text: 'Send')
          ],
        ),
      ),
    );
  }
}
