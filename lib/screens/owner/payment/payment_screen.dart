import 'package:dog_walker/constants.dart';
import 'package:dog_walker/widgets/custom_button.dart';
import 'package:dog_walker/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? fullName, cardNumber, cvv, expiryDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Card Information',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(
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
          Text(
            'Card Details',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(
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
          SizedBox(
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
          SizedBox(
            height: 15,
          ),
          CustomButton(
            onPressed: () {},
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
