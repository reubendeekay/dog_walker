import 'package:dog_walker/screens/owner/dashboard/walker_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class WalkerTile extends StatelessWidget {
  const WalkerTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const WalkerDetailsScreen());
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
                const CircleAvatar(
                  radius: 30,
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Walker Name',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18,
                          ),
                          SizedBox(
                            width: 2.5,
                          ),
                          Text('4.5',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black)),
                        ],
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text('4.5 yrs EXP', style: TextStyle(color: Colors.black)),
                    SizedBox(
                      height: 10,
                    ),
                    Text('\$20/hr', style: TextStyle(color: Colors.black)),
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
