import 'package:dog_walker/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.hintText,
      required this.onChanged,
      this.obscureText = false,
      this.controller,
      this.validator,
      this.isInfinite = false,
      this.keyboardType,
      this.fillColor})
      : super(key: key);

  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool isInfinite;
  final Function(String val)? onChanged;
  final String? Function(String? val)? validator;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLength: null,
        maxLines: isInfinite ? null : 1,
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: kSecondaryColor),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          fillColor: fillColor ?? Colors.white,
          filled: true,
        ),
        style: TextStyle(color: kSecondaryColor.withOpacity(0.5)),
        validator: validator,
      ),
    );
  }
}
