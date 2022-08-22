import 'dart:convert';

import 'package:dog_walker/constants.dart';
import 'package:dog_walker/models/order_model.dart';
import 'package:dog_walker/providers/auth_provider.dart';
import 'package:dog_walker/providers/owner_provider.dart';
import 'package:dog_walker/screens/owner/features/feedback_screen.dart';
import 'package:dog_walker/widgets/custom_button.dart';
import 'package:dog_walker/widgets/custom_textfield.dart';
import 'package:dog_walker/widgets/success_dialog_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

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
              // final owner =
              //     Provider.of<AuthProvider>(context, listen: false).owner!;
              // final request = BraintreePayPalRequest(amount: '13.37');
              // final result = await Braintree.requestPaypalNonce(
              //   tokenizationKey,
              //   request,
              // );
              // if (result != null) {
              //   showNonce(result, context);
              // }
              await completePayment(context);
              // } catch (e) {
              //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //     content: Text(e.toString()),
              // ));
              // }

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

Future<bool> completePayment(BuildContext context) async {
  var request = BraintreeDropInRequest(
    tokenizationKey: tokenizationKey,
    collectDeviceData: true,
    googlePaymentRequest: BraintreeGooglePaymentRequest(
      totalPrice: '4.20',
      currencyCode: 'USD',
      billingAddressRequired: false,
    ),
    paypalRequest: BraintreePayPalRequest(
      amount: '4.20',
      displayName: 'Example company',
    ),
    cardEnabled: true,
  );
  final result = await BraintreeDropIn.start(request);
  if (result != null) {
    showNonce(result.paymentMethodNonce, context);
    return true;
  } else {
    return false;
  }
}

void showNonce(BraintreePaymentMethodNonce nonce, BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Payment Verified'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Text('Thank you for your payment!. Wait for the walker to arrive.'),
        ],
      ),
    ),
  );
}

String tokenizationKey = 'sandbox_8hxpnkht_kzdtzv2btm4p7s5j';
