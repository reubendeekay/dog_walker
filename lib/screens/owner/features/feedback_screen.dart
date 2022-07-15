import 'package:dog_walker/constants.dart';
import 'package:dog_walker/widgets/custom_button.dart';
import 'package:dog_walker/widgets/success_dialog_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/route_manager.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          const Text(
            'Rate Your Experience',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          const Text('Are you satisfied with the service?',
              style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 30),
          RatingBar.builder(
            initialRating: 5,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 6,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: kPrimaryColor,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: TextFormField(
              maxLength: null,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Description',
                hintStyle: TextStyle(color: Colors.grey),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
          const SizedBox(height: 40),
          CustomButton(
            onPressed: () {},
            text: 'Submit',
            textColor: Colors.white,
            radius: 0,
            margin: 0,
          ),
        ]),
      ),
    );
  }
}
