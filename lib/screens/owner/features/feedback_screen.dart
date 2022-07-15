import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_walker/constants.dart';
import 'package:dog_walker/models/order_model.dart';
import 'package:dog_walker/models/review_model.dart';
import 'package:dog_walker/providers/owner_provider.dart';
import 'package:dog_walker/widgets/custom_button.dart';
import 'package:dog_walker/widgets/success_dialog_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key, required this.order}) : super(key: key);
  final OrderModel order;
  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  double? rating;
  String? feedback;
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
              setState(() {
                rating = rating;
              });
            },
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: TextFormField(
              maxLength: null,
              maxLines: null,
              onChanged: (value) {
                setState(() {
                  feedback = value;
                });
              },
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
            onPressed: () async {
              final review = ReviewModel(
                userId: widget.order.userId,
                review: feedback,
                rating: rating.toString(),
                date: Timestamp.now(),
                walkerId: widget.order.walkerId,
                orderId: widget.order.orderId,
              );

              await Provider.of<OwnerProvider>(context, listen: false)
                  .sendReview(review);
              Get.to(() => SuccessDialogScreen(
                    title: 'Success',
                    message: 'Review sent successfully',
                    onComplete: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ));
            },
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
