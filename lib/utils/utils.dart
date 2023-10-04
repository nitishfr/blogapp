import 'package:flutter/material.dart';

showToast(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.deepPurple,
    duration: const Duration(milliseconds: 900),
    margin: EdgeInsets.only(bottom: 10, right: 20, left: 20),
    content: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
  ));
}
