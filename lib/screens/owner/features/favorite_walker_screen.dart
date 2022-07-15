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
                    walker: WalkerModel(
                        description: 'Im the best walker in the world!',
                        name: 'Walker ${index + 1}',
                        ratings: 4.5,
                        email: 'walker${index + 1}@gmail.com',
                        enabled: true,
                        experience: '2',
                        image:
                            'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
                        from: 'Daily',
                        to: 'Daily',
                        hourlyRate: '10',
                        isAvailable: true,
                        lat: 30,
                        long: 30,
                        password: '125152761',
                        id: 'Mofmy0DuowOhJqLnhSIgvvV7t1h1',
                        timing: '10:00 AM - 11:00 PM',
                        reserved: true,
                        userId: 'Mofmy0DuowOhJqLnhSIgvvV7t1h1',
                        userType: 'walker'),
                  ))),
    );
  }
}
