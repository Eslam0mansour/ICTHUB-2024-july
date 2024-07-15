import 'package:flutter/material.dart';

class MyFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const MyFormField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintText,
        label: Text(hintText),
        suffixIcon: Icon(
          Icons.plus_one,
        ),
        prefixIcon: Icon(
          Icons.plus_one,
        ),
        hintStyle: TextStyle(
          color: Colors.red,
        ),
        prefixIconColor: Colors.blue,
      ),
    );
  }
}
