import 'package:dog_walker/models/order_model.dart';
import 'package:dog_walker/screens/owner/payment/payment_screen.dart';
import 'package:dog_walker/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class OwnerNotificationTile extends StatelessWidget {
  const OwnerNotificationTile({Key? key, required this.order})
      : super(key: key);
  final OrderModel order;
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
              children: [
                Text(
                  order.owner!.name!,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                const Spacer(),
                Text(
                  '${order.totalTime}hrs',
                  style: const TextStyle(
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
                Text(
                  '${order.owner!.age} yrs EXP',
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                Expanded(
                    child: CustomButton(
                  onPressed: () {
                    Get.to(() => PaymentScreen(
                          order: order,
                        ));
                  },
                  radius: 2,
                  text: 'PAY',
                  textColor: Colors.white,
                  margin: 30,
                  height: 40,
                )),
                Text(
                  '\$${order.totalCost}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Arrive at ${order.time} on ${order.orderDate}',
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),
          ],
        ));
  }
}
