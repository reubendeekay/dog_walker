import 'package:dog_walker/constants.dart';
import 'package:dog_walker/models/order_model.dart';
import 'package:dog_walker/providers/owner_provider.dart';
import 'package:dog_walker/screens/owner/features/feedback_screen.dart';
import 'package:dog_walker/widgets/custom_button.dart';
import 'package:dog_walker/widgets/custom_textfield.dart';
import 'package:dog_walker/widgets/success_dialog_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key, required this.order}) : super(key: key);
  final OrderModel order;
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? fullName, cardNumber, cvv, expiryDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Card Information',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextField(
            hintText: 'Full Name',
            onChanged: (val) {
              setState(() {
                fullName = val;
              });
            },
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Card Details',
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextField(
            hintText: 'Card Number',
            onChanged: (val) {
              setState(() {
                cardNumber = val;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  hintText: 'Expiry Date',
                  onChanged: (val) {
                    setState(() {
                      expiryDate = val;
                    });
                  },
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: CustomTextField(
                  hintText: 'CVV',
                  onChanged: (val) {
                    setState(() {
                      cvv = val;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          CustomButton(
            onPressed: () async {
              await Provider.of<OwnerProvider>(context, listen: false)
                  .payForWalker(widget.order);
              Get.to(() => SuccessDialogScreen(
                    title: 'Payment\nSuccessful',
                    message:
                        'You have successfully paid for the walker. Review the walker after service is completed.',
                    onComplete: () {
                      Get.to(() => FeedbackScreen(order: widget.order));
                    },
                  ));
            },
            text: 'CONTINUE',
            textColor: Colors.white,
            color: kPrimaryColor,
            margin: 0,
            radius: 0,
          ),
        ]),
      ),
    );
  }
}
