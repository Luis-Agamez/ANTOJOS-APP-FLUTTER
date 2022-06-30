import 'package:flutter/material.dart';

decoration(String labelText, String hintText) {
  return InputDecoration(
      labelStyle: const TextStyle(color: Color.fromARGB(221, 241, 13, 13)),
      labelText: labelText,
      hintText: hintText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          gapPadding: 10,
          borderSide: const BorderSide(color: Colors.black87)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          gapPadding: 10,
          borderSide: const BorderSide(color: Colors.black87)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          gapPadding: 10,
          borderSide: const BorderSide(color: Colors.black87)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          gapPadding: 10,
          borderSide: const BorderSide(color: Colors.black87)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          gapPadding: 10,
          borderSide: const BorderSide(color: Colors.black87)));
}
