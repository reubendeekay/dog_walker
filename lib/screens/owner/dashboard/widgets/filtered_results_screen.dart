import 'package:dog_walker/models/walker_model.dart';
import 'package:dog_walker/providers/owner_provider.dart';
import 'package:dog_walker/screens/owner/dashboard/widgets/walker_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilteredResultsScreen extends StatelessWidget {
  const FilteredResultsScreen(
      {Key? key, required this.price, required this.rating})
      : super(key: key);
  final bool price;
  final bool rating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Search Results'),
        ),
        body: FutureBuilder<List<WalkerModel>>(
          future: Provider.of<OwnerProvider>(context, listen: false)
              .filterResults(price, rating),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            }
            if (snapshot.hasData) {
              final data = snapshot.data!;
              return ListView(
                children: data.map((walker) {
                  return WalkerTile(walker: walker);
                }).toList(),
              );
            }
            return const Center(
              child: Text('No Data'),
            );
          }),
        ));
  }
}
