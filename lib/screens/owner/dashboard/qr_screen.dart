import 'package:dog_walker/models/order_model.dart';
import 'package:dog_walker/providers/auth_provider.dart';
import 'package:dog_walker/providers/owner_provider.dart';
import 'package:dog_walker/screens/walker/dashboard/request_details_screen.dart';
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

              final OrderModel order = orderData['order'];
              order.owner = owner;

              Get.off(() => RequestDetailsScreen(order: order));
              debugPrint('Barcode found! $code');
            }
          }),
    );
  }
}
