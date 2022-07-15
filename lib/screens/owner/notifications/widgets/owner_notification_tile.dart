import 'package:dog_walker/screens/owner/payment/payment_screen.dart';
import 'package:dog_walker/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class OwnerNotificationTile extends StatelessWidget {
  const OwnerNotificationTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Column(
          children: [
            Row(
              children: const [
                Text(
                  'Milo',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                Spacer(),
                Text(
                  '2hrs',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  '2.5 yrs EXP',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Expanded(
                    child: CustomButton(
                  onPressed: () {
                    Get.to(() => const PaymentScreen());
                  },
                  radius: 2,
                  text: 'PAY',
                  textColor: Colors.white,
                  margin: 30,
                  height: 40,
                )),
                const Text(
                  '\$51.00',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Arrive at 7pm on 28th June',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ],
        ));
  }
}
