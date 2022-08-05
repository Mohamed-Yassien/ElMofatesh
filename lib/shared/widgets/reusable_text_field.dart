import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  final TextEditingController controller;
  final String textLabel;
  final bool isPassword;
  final Function validate;
  final VoidCallback? suffixPressed;
  final VoidCallback? onTap;
  final Function? onSubmit;
  final TextInputType type;
  final bool inRating;
  final Function onChange;

  ReusableTextField({
    required this.controller,
    this.isPassword = false,
    required this.textLabel,
    required this.validate,
    this.suffixPressed,
    this.onTap,
    required this.type,
    this.onSubmit,
    this.inRating = false,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.end,
      keyboardType: type,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        labelText: textLabel,
        border: inRating ? null : OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        fillColor: inRating ? null :  Colors.grey[300],
        filled: inRating ? false : true,
      ),
      obscureText: isPassword,
      onTap: onTap,
      onFieldSubmitted: (val) => onSubmit!(val),
      validator: (val) => validate(val),
      onChanged: (val) => onChange(val),
    );
  }
}
