import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_walker/models/order_model.dart';
import 'package:dog_walker/providers/owner_provider.dart';
import 'package:dog_walker/screens/owner/features/feedback_screen.dart';
import 'package:dog_walker/screens/owner/payment/payment_screen.dart';
import 'package:dog_walker/widgets/custom_button.dart';
import 'package:dog_walker/widgets/success_dialog_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class OwnerNotificationTile extends StatelessWidget {
  const OwnerNotificationTile({Key? key, required this.order})
      : super(key: key);
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      order.walker!.name!,
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
                      '${order.walker!.experience} yrs EXP',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                        child: CustomButton(
                      onPressed: () async {
                        final isDone = await completePayment(context);
                        if (isDone) {
                          await Provider.of<OwnerProvider>(context,
                                  listen: false)
                              .payForWalker(order);
                          Get.to(() => SuccessDialogScreen(
                                title: 'Payment\nSuccessful',
                                message:
                                    'You have successfully paid for the walker. Review the walker after service is completed.',
                                onComplete: () {
                                  Get.to(() => FeedbackScreen(order: order));
                                },
                              ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Payment failed'),
                            ),
                          );
                        }
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
            )),
        Positioned(
          top: -7.5,
          right: -7.5,
          child: InkWell(
              onTap: () async {
                await FirebaseFirestore.instance
                    .collection('orders')
                    .doc(order.orderId)
                    .delete();
              },
              child: const Icon(Icons.cancel, color: Colors.red, size: 30)),
        )
      ],
    );
  }
}
