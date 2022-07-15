import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_walker/models/walker_model.dart';
import 'package:dog_walker/screens/owner/dashboard/walker_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class WalkerTile extends StatelessWidget {
  const WalkerTile({Key? key, required this.walker}) : super(key: key);
  final WalkerModel walker;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => WalkerDetailsScreen(
              walker: walker,
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                    radius: 30,
                    backgroundImage: CachedNetworkImageProvider(
                      walker.image!.isEmpty
                          ? 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541'
                          : walker.image!,
                    )),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(walker.name ?? 'Walker Name',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18,
                          ),
                          SizedBox(
                            width: 2.5,
                          ),
                          Text(walker.ratings!.toStringAsFixed(1),
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black)),
                        ],
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${walker.experience} yrs EXP',
                        style: TextStyle(color: Colors.black)),
                    SizedBox(
                      height: 10,
                    ),
                    Text('\$${walker.hourlyRate}/hr',
                        style: TextStyle(color: Colors.black)),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Availability 6pm-8pm',
                style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
