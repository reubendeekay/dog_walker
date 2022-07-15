import 'package:dog_walker/models/walker_model.dart';
import 'package:dog_walker/screens/owner/dashboard/widgets/walker_tile.dart';
import 'package:flutter/material.dart';

class DailyWalkerScreen extends StatelessWidget {
  const DailyWalkerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Walker'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(

          // TODO: Add a list of walkers here.
          children: List.generate(
              10,
              (index) => WalkerTile(
                    walker: WalkerModel(),
                  ))),
    );
  }
}
