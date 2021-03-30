import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget appBar(BuildContext context) {
  return RichText(
      text: TextSpan(style: TextStyle(fontSize: 22), children: <TextSpan>[
    TextSpan(
        text: 'Quiz',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        )),
    TextSpan(
        text: 'App',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        )),
  ]));
}

toast(String message, Color bgColor, Color txColor, double fontSize) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: bgColor,
      textColor: txColor,
      fontSize: fontSize);
}
