import 'package:dog_walker/constants.dart';
import 'package:dog_walker/models/order_model.dart';
import 'package:dog_walker/providers/walker_provider.dart';
import 'package:dog_walker/widgets/custom_button.dart';
import 'package:dog_walker/widgets/success_dialog_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({Key? key, required this.order}) : super(key: key);
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: size.height * 0.2 + kToolbarHeight,
          width: double.infinity,
          child: Image.network(
            order.owner!.image!,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    order.owner!.name!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text('Arrive at ${order.time} on ${order.orderDate}')
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    '\$${order.totalCost}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Text(
                    '${order.time}hrs',
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    order.owner!.address!,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
        ),
        const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Show this QR code on being asked!!',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.all(20.0),
            color: Colors.white,
            child: PrettyQr(
              typeNumber: 3,
              size: 200,
              data: order.orderId!,
              errorCorrectLevel: QrErrorCorrectLevel.M,
              roundEdges: false,
            ),
          ),
        ),
        const Spacer(),
        if (order.status == 'pending')
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () async {
                    try {
                      await Provider.of<WalkerProvider>(context, listen: false)
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
                  text: 'CONTINUE',
                  textColor: Colors.white,
                  color: kPrimaryColor,
                  margin: 5,
                ),
              ),
              Expanded(
                child: CustomButton(
                  onPressed: () async {
                    try {
                      await Provider.of<WalkerProvider>(context, listen: false)
                          .acceptRejectOrder(order.orderId!, false);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
          ),
        const SizedBox(
          height: 15,
        )
      ],
    ));
  }
}
