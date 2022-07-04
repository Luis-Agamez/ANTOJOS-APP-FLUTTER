import 'package:antojos_app/blocs/blocs.dart';
import 'package:antojos_app/theme/theme.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/bottom_red.dart';

class PassScreen extends StatelessWidget {
  const PassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final passOld = TextEditingController();
    final passNew = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 50),
              TextFormField(
                cursorColor: const Color.fromARGB(221, 241, 13, 13),
                keyboardType: TextInputType.text,
                controller: passOld,
                obscureText: true,
                validator: (value) {
                  if (value == null) {
                    return "Este Campo es requerido";
                  }
                  return value.length < 3
                      ? "Este campo  requiere mas de 3 caracteres"
                      : null;
                },
                decoration: decoration(
                    "Contraseña Actual", 'Ingrese la contraseña actual'),
              ),
              const SizedBox(height: 30),
              TextFormField(
                cursorColor: const Color.fromARGB(221, 241, 13, 13),
                keyboardType: TextInputType.text,
                obscureText: true,
                controller: passNew,
                validator: (value) {
                  if (value == null) {
                    return "Este Campo es requerido";
                  }
                  return value.length < 3
                      ? "Este campo  requiere mas de 3 caracteres"
                      : null;
                },
                decoration: decoration(
                    "Nueva Contaseña", 'Ingrese la nueva contraseña'),
              ),
              const SizedBox(
                height: 40,
              ),
              BottomRed(
                text: 'Actualizar',
                onPressed: () async {
                  final resp = await authBloc.passUpdated(
                      passOld.text.trim(), passNew.text.trim());

                  if (resp) {
                    var snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: '¡Mensaje!',
                        message: 'Contraseña Actualizada',
                        contentType: ContentType.success,
                      ),
                    );
                    Navigator.pushNamed(context, 'home');
                    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  var snackBar = SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: '¡Error!',
                      message:
                          'No se pudo actualizar las contraseña revise sus credenciales',
                      contentType: ContentType.failure,
                    ),
                  );

                  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
