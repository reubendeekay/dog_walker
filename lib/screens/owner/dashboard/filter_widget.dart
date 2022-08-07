import 'package:dog_walker/constants.dart';
import 'package:dog_walker/screens/owner/dashboard/widgets/filtered_results_screen.dart';
import 'package:dog_walker/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({Key? key, this.isSearch = false, this.onFilter})
      : super(key: key);
  final bool isSearch;
  final Function(bool price, bool rating)? onFilter;
  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  bool price = false;
  bool rating = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: kSecondaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter & Sorting',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              thickness: 1,
            ),
            const SizedBox(
              height: 15,
            ),
            filter('Price: Low to High', price, (val) {
              setState(() {
                price = val;
              });
            }),
            const SizedBox(
              height: 10,
            ),
            filter('Rating', rating, (val) {
              setState(() {
                rating = val;
              });
            }),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              onPressed: () {
                if (widget.isSearch) {
                  widget.onFilter!(price, rating);
                  Navigator.pop(context);
                }
                if (!widget.isSearch) {
                  Navigator.pop(context);

                  Get.to(() =>
                      FilteredResultsScreen(price: price, rating: rating));
                }
              },
              text: 'Apply',
              margin: 0,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget filter(String title, bool value, Function(bool val) onPressed) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        Switch(
            value: value,
            onChanged: (val) {
              setState(() {
                onPressed(val);
              });
            })
      ],
    );
  }
}
