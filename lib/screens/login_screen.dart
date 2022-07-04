import 'package:antojos_app/blocs/blocs.dart';
import 'package:antojos_app/widgets/bottom_red.dart';
import 'package:antojos_app/widgets/label.dart';
import 'package:antojos_app/widgets/logo.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/custom_input.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                    title: 'Crear Cuenta Ahora!',
                    route: 'register',
                    subTitle: 'No tienes una cuenta?',
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

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: <Widget>[
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
                text: 'Login',
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  final loginOk = await authBloc.login(
                      emailCtrl.text.trim(), passCtrl.text.trim());
                  if (loginOk) {
                    print('login success');
                    Navigator.pushReplacementNamed(context, 'home');
                  } else {
                    var snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: '¡Error!',
                        message: 'Usuario o contraseña son incorrectas',
                        contentType: ContentType.failure,
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }),
          ],
        ));
  }
}
