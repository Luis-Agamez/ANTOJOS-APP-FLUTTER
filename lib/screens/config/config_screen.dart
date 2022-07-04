import 'package:antojos_app/blocs/blocs.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/bottom_red.dart';
import '../../widgets/data_input.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final user = authBloc.state.user;
    final name = TextEditingController(text: user!.name);
    final lastName = TextEditingController(text: user.lastName);
    final email = TextEditingController(text: user.email);
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Form(
            child: Column(
          children: [
            const SizedBox(height: 50),
            data_input(
              textController: name,
              minimum: 3,
              placeholder: 'Primer Nombre',
              subTitle: 'Nombre',
              type: TextInputType.text,
            ),
            const SizedBox(height: 30),
            data_input(
              textController: lastName,
              minimum: 3,
              placeholder: 'Apellido',
              subTitle: 'Primer Apellido',
              type: TextInputType.text,
            ),
            const SizedBox(height: 30),
            data_input(
              textController: email,
              minimum: 3,
              placeholder: 'Correo',
              subTitle: 'Correo',
              type: TextInputType.text,
            ),
            const SizedBox(height: 30),
            BottomRed(
                text: 'Actualizar',
                onPressed: () async {
                  authBloc.activeLoading();
                  FocusScope.of(context).unfocus();
                  final registerOk = await authBloc.updatedData(
                      name.text.trim(),
                      lastName.text.trim(),
                      email.text.trim());
                  authBloc.desactiveLoading();
                  if (registerOk) {
                    var snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: '¡Mensaje!',
                        message: 'Datos Actualizados',
                        contentType: ContentType.success,
                      ),
                    );
                    Navigator.pushNamed(context, 'home');
                    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    var snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: '¡Error!',
                        message: 'No se pudo actualizar los Datos',
                        contentType: ContentType.failure,
                      ),
                    );

                    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }),
          ],
        )),
      ),
    ));
  }
}
