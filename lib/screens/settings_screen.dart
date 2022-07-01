import 'package:antojos_app/widgets/config_body.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(221, 241, 13, 13),
        title: const Text(
          'Mi cuenta',
          style: TextStyle(
            fontFamily: 'Lobster',
            letterSpacing: 3,
            fontSize: 30,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
      body: const Center(
        child: ConfigBody(),
      ),
    );
  }
}
