import 'package:dog_walker/models/order_model.dart';
import 'package:dog_walker/models/walker_model.dart';
import 'package:dog_walker/providers/owner_provider.dart';
import 'package:dog_walker/screens/owner/dashboard/widgets/hour_stepper.dart';
import 'package:dog_walker/widgets/custom_button.dart';
import 'package:dog_walker/widgets/success_dialog_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WalkerDetailsScreen extends StatefulWidget {
  const WalkerDetailsScreen({Key? key, required this.walker}) : super(key: key);
  final WalkerModel walker;

  @override
  State<WalkerDetailsScreen> createState() => _WalkerDetailsScreenState();
}

class _WalkerDetailsScreenState extends State<WalkerDetailsScreen> {
  int hours = 1;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  double totalAmount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalAmount = double.parse(widget.walker.hourlyRate!);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height * 0.3,
          width: double.infinity,
          child: Image.network(
            widget.walker.image!.isEmpty
                ? 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541'
                : widget.walker.image!,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.walker.name!.isEmpty ? 'Adam' : widget.walker.name!,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  const SizedBox(
                    width: 2.5,
                  ),
                  Text(widget.walker.ratings!.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 20,
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    '\$${widget.walker.hourlyRate}/hr',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Text(
                        widget.walker.from == 'Daily'
                            ? 'Daily'
                            : '${widget.walker.from} to ${widget.walker.to}',
                      ),
                      Text(
                        widget.walker.timing!,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Text('Description'),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.walker.description!,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 2.5,
                      ),
                      Text(
                        '\$${totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const Spacer(),
                  HourStepper(
                    onChange: (hours) => setState(() {
                      this.hours = hours;
                      totalAmount =
                          double.parse(widget.walker.hourlyRate!) * hours;
                    }),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Text('Select Date and Time for Adam to come:'),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2050),
                  );
                  setState(() {});
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.bottomLeft,
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey))),
                  child: Text(
                    selectedDate == null
                        ? 'Select Date'
                        : DateFormat('MM/dd/yyyy').format(selectedDate!),
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  setState(() {});
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.bottomLeft,
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey))),
                  child: Text(
                    selectedTime == null
                        ? 'Select Time'
                        : selectedTime!.format(context),
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                onPressed: selectedDate == null || selectedTime == null
                    ? null
                    : () async {
                        final order = OrderModel(
                          walkerId: widget.walker.userId,
                          orderDate:
                              DateFormat('dd/MM/yyyy').format(selectedDate!),
                          time: selectedTime!.format(context),
                          totalCost: totalAmount.toStringAsFixed(2),
                          totalTime: hours.toString(),
                          userId: FirebaseAuth.instance.currentUser!.uid,
                        );
                        try {
                          await Provider.of<OwnerProvider>(context,
                                  listen: false)
                              .requestWalker(order);

                          Get.to(() => SuccessDialogScreen(
                              title: 'Request\nSent',
                              message:
                                  'We have sent the request to the walker.\nHe will soon catch jup!!',
                              onComplete: () {}));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(e.toString()),
                          ));
                        }
                      },
                text: 'PROCEED',
                textColor: Colors.white,
                margin: 60,
              )
            ],
          ),
        )
      ],
    ));
  }
}
