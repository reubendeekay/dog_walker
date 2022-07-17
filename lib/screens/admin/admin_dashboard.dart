import 'package:dog_walker/screens/admin/all_owners.dart';
import 'package:dog_walker/screens/admin/all_walkers.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            unselectedLabelColor: Colors.white,
            labelColor: Colors.purple,
            indicatorColor: Colors.purple,
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
        body: const TabBarView(
          children: [
            AllWalkers(),
            AllOwners(),
          ],
        ),
      ),
    );
  }
}
