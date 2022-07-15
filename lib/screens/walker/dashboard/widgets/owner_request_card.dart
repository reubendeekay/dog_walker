import 'package:dog_walker/constants.dart';
import 'package:dog_walker/screens/walker/dashboard/request_details_screen.dart';
import 'package:dog_walker/widgets/custom_button.dart';
import 'package:dog_walker/widgets/success_dialog_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class OwnerRequestCard extends StatelessWidget {
  const OwnerRequestCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const RequestDetailsScreen());
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset('assets/images/red_dog.png'),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Milo',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '2.5 yrs',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '3400 Chenagai Street',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Arrive at 7pmon 20th July',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: const [
                    Text(
                      '2hrs',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '\$51.00',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      Get.to(() => SuccessDialogScreen(
                          title: 'Request\nSent',
                          message:
                              'Good work leads to more requests!!!\nHave a good day.',
                          onComplete: () {}));
                    },
                    text: 'APPLY',
                    textColor: Colors.white,
                    color: kPrimaryColor,
                    margin: 5,
                  ),
                ),
                Expanded(
                  child: CustomButton(
                    onPressed: () {},
                    text: 'REJECT',
                    textColor: Colors.white,
                    color: Colors.red,
                    margin: 5,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
