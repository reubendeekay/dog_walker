import 'package:dog_walker/models/order_model.dart';
import 'package:dog_walker/providers/walker_provider.dart';
import 'package:dog_walker/screens/walker/dashboard/widgets/owner_request_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestsScreen extends StatelessWidget {
  const RequestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Requests'),
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            labelColor: Colors.white,
            tabs: [
              Tab(
                text: 'ACCEPTED',
              ),
              Tab(
                text: 'REJECTED',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            screen(true, context),
            screen(false, context),
          ],
        ),
      ),
    );
  }

  Widget screen(bool isAccepted, BuildContext context) {
    return FutureBuilder<List<OrderModel>>(
        future: Provider.of<WalkerProvider>(context, listen: false)
            .getOrders(accepted: isAccepted),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No requests yet'),
            );
          }
          final data = snapshot.data!;
          return Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    children: List.generate(
                        data.length,
                        (index) => OwnerRequestCard(
                              order: data[index],
                            ))),
              ),
            ],
          );
        });
  }
}
