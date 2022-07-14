import 'package:flutter/material.dart';

class HourStepper extends StatefulWidget {
  const HourStepper({Key? key, required this.onChange}) : super(key: key);
  final Function(int hours) onChange;

  @override
  State<HourStepper> createState() => _HourStepperState();
}

class _HourStepperState extends State<HourStepper> {
  int hours = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        button(Icons.add, () {
          setState(() {
            hours++;
            widget.onChange(hours);
          });
        }),
        const SizedBox(
          width: 5,
        ),
        Text(
          '${hours}hr',
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          width: 5,
        ),
        button(Icons.remove, () {
          setState(() {
            if (hours > 1) hours--;
            widget.onChange(hours);
          });
        }),
      ],
    );
  }

  Widget button(IconData icon, Function onTap) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
        ),
        child: Icon(
          icon,
        ),
      ),
    );
  }
}
