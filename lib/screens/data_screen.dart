import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/theme.dart';
import '../widgets/bottom_red.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(221, 241, 13, 13),
        title: Text('Mi cuenta',
            style: GoogleFonts.lobster(
              textStyle: const TextStyle(
                letterSpacing: 3,
                fontSize: 30,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            )),
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
                  _Form()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({super.key});

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final _formKey = GlobalKey<FormState>();
  late String cellPhoneNumber;
  late String address;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const SizedBox(height: 50),
          TextFormField(
            cursorColor: const Color.fromARGB(221, 241, 13, 13),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null) {
                return "Este Campo es requerido";
              }
              return value.length < 3
                  ? "Este campo  requiere mas de 3 caracteres"
                  : null;
            },
            decoration: decoration("Telefono", "Ingrese su Telefono"),
          ),
          const SizedBox(height: 30),
          TextFormField(
            cursorColor: const Color.fromARGB(221, 241, 13, 13),
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null) {
                return "Este Campo es requerido";
              }
              return value.length < 3
                  ? "Este campo  requiere mas de 3 caracteres"
                  : null;
            },
            decoration: decoration("Ciudad", "Ingrese la Ciudad o Municipio"),
          ),
          const SizedBox(height: 30),
          TextFormField(
            cursorColor: const Color.fromARGB(221, 241, 13, 13),
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null) {
                return "Este Campo es Requerido";
              }
              return value.length < 3
                  ? "Este campo  requiere mas de 3 caracteres"
                  : null;
            },
            decoration: decoration("Barrio", "Ingrese el Barrio o localidad"),
          ),
          const SizedBox(height: 30),
          TextFormField(
            cursorColor: const Color.fromARGB(221, 241, 13, 13),
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null) {
                return "Este Campo es requerido";
              }
              return value.length < 3
                  ? "Este campo  requiere mas de 3 caracteres"
                  : null;
            },
            decoration:
                decoration("Referencia", "Ingrese Referencia Adicional"),
          ),
          const SizedBox(height: 40),
          BottomRed(
              text: 'Continuar',
              onPressed: () async {
                FocusScope.of(context).unfocus();
                Navigator.pushReplacementNamed(context, 'home');
              }),
        ],
      ),
    );
  }
}
