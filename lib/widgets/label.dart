import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Labels extends StatelessWidget {
  final String route;
  final String title;
  final String subTitle;
  const Labels(
      {Key? key,
      required this.route,
      required this.title,
      required this.subTitle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Text(subTitle,
            style: GoogleFonts.lobster(
              textStyle: const TextStyle(
                  color: Color.fromARGB(202, 0, 0, 0),
                  fontSize: 18,
                  fontWeight: FontWeight.w300),
            )),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, route);
          },
          child: Text(
            title,
            style: GoogleFonts.lobster(
              textStyle: const TextStyle(
                letterSpacing: 1,
                fontSize: 22,
                color: Color.fromARGB(221, 241, 13, 13),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
