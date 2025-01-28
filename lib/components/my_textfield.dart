import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final String hintText;
  final controller;
  final bool obscureText;

  const MyTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
          controller: controller,
          obscureText: obscureText,
          
          decoration: InputDecoration(
              hintText: hintText,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              fillColor: Colors.grey.shade200,
              filled: true)),
    );
  }
}
