import 'package:antojos_app/widgets/bottom_red.dart';
import 'package:antojos_app/widgets/label.dart';
import 'package:antojos_app/widgets/logo.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/user/user_bloc.dart';
import '../widgets/custom_input.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Logo(title: 'Antojos'),
                  _Form(),
                  const Labels(
                    title: 'iniciar Sesion Ahora!',
                    subTitle: 'Tienes una cuenta?',
                    route: 'login',
                  ),
                  const Text(
                    'Terminos y condiciones de Uso ',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    late UserBloc userBloc;
    userBloc = BlocProvider.of<UserBloc>(context);
    return Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: <Widget>[
            CustomInput(
                icon: Icons.perm_identity,
                placeholder: 'Primer Nombre',
                keyboardType: TextInputType.text,
                textController: nameCtrl),
            CustomInput(
                icon: Icons.perm_identity,
                placeholder: 'Primer Apellido',
                keyboardType: TextInputType.text,
                textController: lastNameCtrl),
            CustomInput(
                icon: Icons.email_outlined,
                placeholder: 'Email',
                keyboardType: TextInputType.emailAddress,
                textController: emailCtrl),
            CustomInput(
                icon: Icons.lock_outline,
                placeholder: 'Password',
                isPassword: true,
                textController: passCtrl),
            //Create Buttom
            BottomRed(
                text: 'Register',
                onPressed: () async {
                  late String text;
                  if (passCtrl.text.length < 6) {
                    text = 'la contraseña debe tener mas de 6 caracteres';
                  }

                  if (emailCtrl.text.length < 11) {
                    text = 'El email debe tener minimo de 11 caracteres ';
                  }

                  if (lastNameCtrl.text.length < 5) {
                    text = 'El apellido debe tener minimo de 4 caracteres';
                  }
                  if (passCtrl.text.length < 6) {
                    text = 'la contraseña debe tener minimo de 6 caracteres';
                  }
                  if (nameCtrl.text.length < 4) {
                    text = 'El nombre debe tener minimo de 3 caracteres';
                  }

                  if (nameCtrl.text.length < 4 ||
                      passCtrl.text.length < 6 ||
                      lastNameCtrl.text.length < 4 ||
                      emailCtrl.text.length < 11 ||
                      passCtrl.text.length < 6) {
                    var snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: '¡Error!',
                        message: text,
                        contentType: ContentType.failure,
                      ),
                    );

                    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }

                  final state = userBloc.state;

                  userBloc.setData(nameCtrl.text.trim(), emailCtrl.text.trim(),
                      lastNameCtrl.text.trim(), passCtrl.text.trim());

                  FocusScope.of(context).unfocus();
                  Navigator.pushReplacementNamed(context, 'data');
                }),
          ],
        ));
  }
}
