import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget appBar(BuildContext context) {
  return RichText(
      text: TextSpan(style: TextStyle(fontSize: 22), children: <TextSpan>[
    TextSpan(
        text: 'Quiz',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xff00BFA6),
        )),
    TextSpan(
        text: 'Triv',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black54,
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
