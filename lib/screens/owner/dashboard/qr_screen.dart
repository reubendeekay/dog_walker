import 'package:dog_walker/models/order_model.dart';
import 'package:dog_walker/providers/auth_provider.dart';
import 'package:dog_walker/providers/owner_provider.dart';
import 'package:dog_walker/screens/walker/dashboard/request_details_screen.dart';
import 'package:dog_walker/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class QrScreen extends StatelessWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final owner = Provider.of<AuthProvider>(context, listen: false).owner;
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Walker')),
      body: MobileScanner(
          allowDuplicates: false,
          onDetect: (barcode, args) async {
            if (barcode.rawValue == null) {
              debugPrint('Failed to scan Barcode');
            } else {
              final String code = barcode.rawValue!;
              final orderData =
                  await Provider.of<OwnerProvider>(context, listen: false)
                      .verifyWalker(code);

              if (orderData != null) {
                final OrderModel order = orderData['order'];
                order.owner = owner;

                Get.off(() => RequestDetailsScreen(order: order));
                debugPrint('Barcode found! $code');
              } else {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    actions: [
                      CustomButton(
                        text: 'OK',
                        onPressed: () {
                          Get.back();
                          Get.back();
                        },
                      ),
                    ],
                    title: const Text('Walker Not Verified'),
                    content:
                        const Text('Please pay for the walker to verify them'),
                  ),
                );
                Future.delayed(const Duration(seconds: 3), () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              }
            }
          }),
    );
  }
}
