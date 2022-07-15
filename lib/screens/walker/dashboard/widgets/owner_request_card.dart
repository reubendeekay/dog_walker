import 'package:dog_walker/constants.dart';
import 'package:dog_walker/models/order_model.dart';
import 'package:dog_walker/providers/walker_provider.dart';
import 'package:dog_walker/screens/walker/dashboard/request_details_screen.dart';
import 'package:dog_walker/widgets/custom_button.dart';
import 'package:dog_walker/widgets/success_dialog_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class OwnerRequestCard extends StatelessWidget {
  const OwnerRequestCard({Key? key, required this.order}) : super(key: key);
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => RequestDetailsScreen(
              order: order,
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  height: 90,
                  child: Image.network(
                    order.owner!.image!,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.owner!.name!,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${order.owner!.age} yrs',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        order.owner!.address!,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Arrive on ${order.orderDate} at ${order.time}',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Text(
                      '${order.totalTime} hrs',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '\$${order.totalCost}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                )
              ],
            ),
            if (order.status == 'pending')
              const SizedBox(
                height: 10,
              ),
            if (order.status == 'pending')
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () async {
                        try {
                          await Provider.of<WalkerProvider>(context,
                                  listen: false)
                              .acceptRejectOrder(order.orderId!, true);

                          Get.to(() => SuccessDialogScreen(
                              title: 'Request\nSent',
                              message:
                                  'Good work leads to more requests!!!\nHave a good day.',
                              onComplete: () {}));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );
                        }
                      },
                      text: 'APPLY',
                      textColor: Colors.white,
                      color: kPrimaryColor,
                      margin: 5,
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      onPressed: () async {
                        try {
                          await Provider.of<WalkerProvider>(context,
                                  listen: false)
                              .acceptRejectOrder(order.orderId!, false);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Request rejected'),
                          ));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );
                        }
                      },
                      text: 'REJECT',
                      textColor: Colors.white,
                      color: Colors.red,
                      margin: 5,
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
