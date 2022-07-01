import 'package:flutter/material.dart';
import '../widgets/form_data.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({super.key});

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
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: const <Widget>[
                  Text('Informacion Personal',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          height: 1.5)),
                  Text(
                    'Completa tu informacion Personal Para que podamos enviar tus pedidos',
                    textAlign: TextAlign.center,
                  ),
                  FormData(
                    textPhone: '',
                    textCity: '',
                    textDistrict: '',
                    textReference: '',
                    register: true,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
