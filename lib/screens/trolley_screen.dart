import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrolleyScreen extends StatelessWidget {
  const TrolleyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(221, 241, 13, 13),
        title: Text('Carrito',
            style: GoogleFonts.lobster(
              textStyle: const TextStyle(
                letterSpacing: 3,
                fontSize: 30,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            )),
      ),
      body: const Center(
        child: Text('TrolleyScreen'),
      ),
    );
  }
}
