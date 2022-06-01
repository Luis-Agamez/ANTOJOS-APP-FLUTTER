import 'package:antojos_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: chackLoginState(context),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return const Center(
          child: Text('Loading...'),
        );
      },
    ));
  }

  Future chackLoginState(BuildContext context) async {
    late AuthBloc authBloc;
    authBloc = BlocProvider.of<AuthBloc>(context);

    final autenticated = await authBloc.idLogggedIn();

    if (autenticated) {
      // Connect to Socket Server
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => const HomeScreen(),
              transitionDuration: Duration(milliseconds: 0)));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => const LoginScreen(),
              transitionDuration: Duration(milliseconds: 0)));
    }
  }
}
