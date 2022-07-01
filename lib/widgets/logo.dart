import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String title;
  const Logo({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 300,
      margin: const EdgeInsets.only(top: 50),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
                letterSpacing: 1,
                fontSize: 60,
                color: Color.fromARGB(221, 241, 13, 13),
                fontFamily: 'Lobster'),
          ),
          const SizedBox(height: 40)
        ],
      ),
    ));
  }
}
