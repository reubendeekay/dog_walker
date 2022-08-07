import 'package:dog_walker/models/walker_model.dart';
import 'package:dog_walker/providers/owner_provider.dart';
import 'package:dog_walker/screens/owner/dashboard/filter_widget.dart';
import 'package:dog_walker/screens/owner/dashboard/widgets/walker_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({Key? key, required this.searchTerm})
      : super(key: key);
  final String searchTerm;

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  bool price = false;

  bool rating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Search Results'),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_alt),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: FilterWidget(
                            isSearch: true,
                            onFilter: (price, rating) => setState(() {
                              this.price = price;
                              this.rating = rating;
                            }),
                          ),
                        ));
              },
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: FutureBuilder<List<WalkerModel>>(
          future: Provider.of<OwnerProvider>(context, listen: false)
              .searchWalker(widget.searchTerm, price, rating),
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
