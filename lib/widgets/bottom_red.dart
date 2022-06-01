import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomRed extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  const BottomRed({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 2,
      hoverElevation: 5,
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration:
            // TODO Action
            // ? BoxDecoration(
            //     color: Colors.grey, borderRadius: BorderRadius.circular(32))
            BoxDecoration(
                color: const Color.fromARGB(221, 241, 13, 13),
                borderRadius: BorderRadius.circular(32)),
        child: Center(
            child: Text(
          text,
          style: GoogleFonts.lobster(
              textStyle: const TextStyle(
                  color: Colors.white, fontSize: 28, letterSpacing: 2)),
        )),
      ),
    );
  }
}
