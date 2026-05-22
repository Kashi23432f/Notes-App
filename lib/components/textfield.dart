import 'package:flutter/material.dart';

class CustTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final int maxLines;
  final Function(String)? onChanged;

  const CustTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.maxLines = 1,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      controller: controller,
      maxLines: maxLines,
      onChanged: onChanged,
    );
  }
}
