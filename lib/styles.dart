import 'package:flutter/material.dart';

class AppStyles {
  Color themeColor = Color.fromARGB(255, 255, 159, 170);
  Color themeColorLight = Color.fromARGB(255, 253, 225, 228);
  InputDecoration textFieldDecoration({String? label, String? hintText}) =>
      InputDecoration(
        label: Padding(
          padding:EdgeInsets.only(left: 8.0),
          child: Text(
            label!,
            style: TextStyle(color: Color.fromARGB(255, 110, 103, 103),fontSize: 18),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 255, 159, 170), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: Color.fromRGBO(217, 4, 41, 1), width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: Color.fromRGBO(217, 4, 41, 1), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color.fromARGB(255, 255, 159, 170), width: 1.5),
        ),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 35),
      );
}