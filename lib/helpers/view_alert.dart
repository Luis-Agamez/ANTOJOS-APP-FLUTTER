import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

viewAlert(BuildContext context, String title, String subTitle) {
  if (Platform.isAndroid) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              titlePadding:
                  const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              backgroundColor: const Color.fromARGB(255, 251, 255, 253),
              title: Text(title.toUpperCase()),
              content: Text(subTitle.toUpperCase()),
              actions: [
                MaterialButton(
                    child: const Text(
                      'OK',
                      style: TextStyle(
                          color: Color.fromARGB(221, 241, 13, 13),
                          fontSize: 22),
                    ),
                    textColor: const Color.fromARGB(221, 241, 13, 13),
                    elevation: 5,
                    onPressed: () => Navigator.pop(context))
              ],
            ));
  } else {
    showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(subTitle),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text(
                    'OK',
                    style: TextStyle(
                        color: Color.fromARGB(221, 241, 13, 13), fontSize: 25),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ));
  }
}
