import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0
  );
}

String convertToDay(int dayInNum) {
  String result = "";
  switch (dayInNum) {
    case 1:
      result = "Sun";
      break;
    case 2:
      result = "Mon";
      break;
    case 3:
      result = "Tue";
      break;
    case 4:
      result = "Wed";
      break;
    case 5:
      result = "Thu";
      break;
    case 6:
      result = "Fri";
      break;
    case 7:
      result = "Sat";
      break;
  }
  return result;
}