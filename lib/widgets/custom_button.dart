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
      this.height,
      this.radius,
      this.width})
      : super(key: key);
  final String text;
  final Function? onPressed;
  final Color? color;
  final double? width;
  final Color? textColor;
  final double? margin;
  final double? radius;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 45,
      width: width ?? double.infinity,
      margin: EdgeInsets.symmetric(horizontal: margin ?? 20),
      child: RaisedButton(
          onPressed: onPressed == null ? null : () => onPressed!(),
          textColor: textColor ?? kSecondaryColor,
          color: color ?? kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 10),
          ),
          child: Text(text)),
    );
  }
}
