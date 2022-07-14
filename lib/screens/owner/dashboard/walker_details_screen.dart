import 'package:dog_walker/screens/owner/dashboard/widgets/hour_stepper.dart';
import 'package:dog_walker/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WalkerDetailsScreen extends StatefulWidget {
  const WalkerDetailsScreen({Key? key}) : super(key: key);

  @override
  State<WalkerDetailsScreen> createState() => _WalkerDetailsScreenState();
}

class _WalkerDetailsScreenState extends State<WalkerDetailsScreen> {
  int hours = 1;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

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
            'https://thumbs.dreamstime.com/b/happy-dog-walker-enjoying-dogs-walking-outdoors-woman-147232820.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Text(
                    'Adam',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  SizedBox(
                    width: 2.5,
                  ),
                  Text('4.5',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    '\$25.50/hr',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Column(
                    children: const [
                      Text(
                        '3/08/22 to 9/08/22',
                      ),
                      Text(
                        '6pm to 10pm',
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
              const Text(
                'My name is Adam. I am 25 yrs old. I love dogs and I love taking care of them. I am open to job opportunities as a dog walker. If you would like to hire me as a dog walker please hit the button below to proceed.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Total',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 2.5,
                      ),
                      Text(
                        '\$51.00',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const Spacer(),
                  HourStepper(
                    onChange: (hours) => setState(() => this.hours = hours),
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
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey))),
                  child: Text(
                    selectedDate == null
                        ? 'Select Date'
                        : DateFormat('MM/dd/yyyy').format(selectedDate!),
                    style: TextStyle(color: Colors.grey, fontSize: 16),
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
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey))),
                  child: Text(
                    selectedTime == null
                        ? 'Select Time'
                        : selectedTime!.format(context),
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CustomButton(
                onPressed: () {},
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
