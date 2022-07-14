import 'package:dog_walker/screens/walker/dashboard/widgets/owner_request_card.dart';
import 'package:flutter/material.dart';

class WalkerDashboard extends StatelessWidget {
  const WalkerDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.people),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.filter_alt),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 15, left: 15),
              child: Text(
                'Hellow William',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
                child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                ...List.generate(10, (index) => const OwnerRequestCard())
              ],
            ))
          ],
        ));
  }
}
