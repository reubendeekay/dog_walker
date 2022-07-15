import 'package:dog_walker/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SuccessDialogScreen extends StatefulWidget {
  const SuccessDialogScreen({
    Key? key,
    required this.title,
    required this.message,
    required this.onComplete,
  }) : super(key: key);
  final String title;
  final String message;
  final Function? onComplete;

  @override
  State<SuccessDialogScreen> createState() => _SuccessDialogScreenState();
}

class _SuccessDialogScreenState extends State<SuccessDialogScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 0), () async {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => Dialog(
                insetPadding: const EdgeInsets.all(20),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const SuccessDialog(),
              ));

      Future.delayed(Duration(seconds: 5), () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        widget.onComplete?.call();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.1 + kToolbarHeight),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Payment',
            style: TextStyle(fontSize: 24, color: kPrimaryColor),
          ),
        ),
      ]),
    );
  }
}

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        const SizedBox(height: 20),
        Icon(
          FontAwesomeIcons.paperPlane,
          color: kSecondaryColor,
          size: 50,
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          'Thank you so much.\nTransaction has been completed.\nHave a good day.',
          textAlign: TextAlign.center,
          style: TextStyle(color: kSecondaryColor, fontSize: 16),
        ),
        const SizedBox(height: 20),
      ]),
    ));
  }
}
