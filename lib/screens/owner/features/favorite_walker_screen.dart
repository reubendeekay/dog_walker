import 'package:dog_walker/models/walker_model.dart';
import 'package:dog_walker/screens/owner/dashboard/widgets/walker_tile.dart';
import 'package:flutter/material.dart';

class FavoriteWalkerScreen extends StatelessWidget {
  const FavoriteWalkerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Walker'),
        automaticallyImplyLeading: false,
      ),

      // TODO: Add a list of walkers here.
      body: ListView(
          children: List.generate(
              10,
              (index) => WalkerTile(
                    walker: WalkerModel(),
                  ))),
    );
  }
}
