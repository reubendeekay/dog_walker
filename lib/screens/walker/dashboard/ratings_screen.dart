import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_walker/constants.dart';
import 'package:dog_walker/models/owner_model.dart';
import 'package:dog_walker/models/review_model.dart';
import 'package:dog_walker/providers/walker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class WalkerRatingsScreen extends StatelessWidget {
  const WalkerRatingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Ratings')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
          future: Provider.of<WalkerProvider>(context, listen: false)
              .getWalkerRatings(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: snapshot.data!
                  .map((e) =>
                      UserRatingCard(owner: e['owner'], review: e['review']))
                  .toList(),
            );
          }),
    );
  }
}

class UserRatingCard extends StatelessWidget {
  const UserRatingCard({Key? key, required this.owner, required this.review})
      : super(key: key);
  final ReviewModel review;
  final OwnerModel owner;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 7.5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(owner.image!),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    owner.name!,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 2.5),
                  RatingBar.builder(
                    initialRating: double.parse(review.rating!),
                    minRating: 1,
                    itemSize: 15,
                    tapOnlyMode: true,
                    ignoreGestures: true,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 6,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: kPrimaryColor,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    review.review!,
                    style: const TextStyle(color: Colors.black),
                  )
                ],
              ),
            ),
          ],
        )
      ]),
    );
  }
}
