import 'package:dog_walker/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.color,
      this.textColor,
      this.margin,
      this.width})
      : super(key: key);
  final String text;
  final Function onPressed;
  final Color? color;
  final double? width;
  final Color? textColor;
  final double? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: width ?? double.infinity,
      margin: EdgeInsets.symmetric(horizontal: margin ?? 20),
      child: RaisedButton(
          onPressed: () => onPressed(),
          textColor: textColor ?? kSecondaryColor,
          color: color ?? kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(text)),
    );
  }
}
