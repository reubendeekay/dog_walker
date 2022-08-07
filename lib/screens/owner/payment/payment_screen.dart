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
              final card = CardDetails(
                cvc: cvv,
                expirationMonth: int.parse(expiryDate!.split('/').first),
                expirationYear: int.parse(expiryDate!.split('/').last),
                number: cardNumber,
              );
              try {
                await _handlePayPress(context, card);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(e.toString()),
                ));
              }

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

Future<void> _handlePayPress(BuildContext context, CardDetails _card) async {
  await Stripe.instance.dangerouslyUpdateCardDetails(_card);
  final owner = Provider.of<AuthProvider>(context, listen: false).owner!;

  try {
    // 1. Gather customer billing information (ex. email)

    final billingDetails = BillingDetails(
      email: owner.email!,
      phone: '+48888000888',
      address: Address(
        city: 'Houston',
        country: 'US',
        line1: '1459  Circle Drive',
        line2: '',
        state: 'Texas',
        postalCode: '77063',
      ),
    ); // mocked data for tests

    // 2. Create payment method
    final paymentMethod =
        await Stripe.instance.createPaymentMethod(PaymentMethodParams.card(
      paymentMethodData: PaymentMethodData(
        billingDetails: billingDetails,
      ),
    ));

    // 3. call API to create PaymentIntent
    final paymentIntentResult = await callNoWebhookPayEndpointMethodId(
      useStripeSdk: true,
      paymentMethodId: paymentMethod.id,
      currency: 'usd', // mocked data
      items: [
        {'id': 'id'}
      ],
    );

    if (paymentIntentResult['error'] != null) {
      // Error during creating or confirming Intent
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${paymentIntentResult['error']}')));
      return;
    }

    if (paymentIntentResult['clientSecret'] != null &&
        paymentIntentResult['requiresAction'] == null) {
      // Payment succedeed

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Success!: The payment was confirmed successfully!')));
      return;
    }

    if (paymentIntentResult['clientSecret'] != null &&
        paymentIntentResult['requiresAction'] == true) {
      // 4. if payment requires action calling handleNextAction
      final paymentIntent = await Stripe.instance
          .handleNextAction(paymentIntentResult['clientSecret']);

      if (paymentIntent.status == PaymentIntentsStatus.RequiresConfirmation) {
        // 5. Call API to confirm intent
        await confirmIntent(paymentIntent.id, context);
      } else {
        // Payment succedeed
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${paymentIntentResult['error']}')));
      }
    }
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Error: $e')));
    rethrow;
  }
}

Future<void> confirmIntent(String paymentIntentId, BuildContext context) async {
  final result =
      await callNoWebhookPayEndpointIntentId(paymentIntentId: paymentIntentId);
  if (result['error'] != null) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Error: ${result['error']}')));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Success!: The payment was confirmed successfully!')));
  }
}

Future<Map<String, dynamic>> callNoWebhookPayEndpointIntentId({
  required String paymentIntentId,
}) async {
  final url = Uri.parse('$kApiUrl/charge-card-off-session');
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode({'paymentIntentId': paymentIntentId}),
  );
  return json.decode(response.body);
}

Future<Map<String, dynamic>> callNoWebhookPayEndpointMethodId({
  required bool useStripeSdk,
  required String paymentMethodId,
  required String currency,
  List<Map<String, dynamic>>? items,
}) async {
  final url = Uri.parse('$kApiUrl/pay-without-webhooks');
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'useStripeSdk': useStripeSdk,
      'paymentMethodId': paymentMethodId,
      'currency': currency,
      'items': items
    }),
  );
  return json.decode(response.body);
}

const kApiUrl = 'http://10.0.2.2:4242';
