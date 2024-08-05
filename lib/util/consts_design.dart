import 'dart:js';

import 'package:flutter/material.dart';

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color.fromARGB(255, 88, 191, 255);
const bgColor = Color.fromARGB(255, 125, 201, 245);
const defaultPadding = 16.0;
const Color txtColor = Colors.white;
const Color iconColor = Colors.white;
const EdgeInsets margin13 = EdgeInsets.only(left: 13.0);
inputDecorationEnabledBorder() {
  return OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.white, width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(10)),
  );
}

inputDecorationFocusedBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(width: 1, color: Colors.blue),
  );
}

inputDecorationBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );
}

searchButtonSuffixDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    color: Colors.blue,
  );
}

dropDownDecoration() {
  return BoxDecoration(
    border: Border.all(color: Colors.blue, width: 1.0),
    borderRadius: BorderRadius.circular(10),
  );
}
