import 'package:antojos_app/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/side_menu.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late AuthBloc authBloc;
    authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      drawer: BlocBuilder<AuthBloc, AuthState>(builder: (_, state) {
        return state.existsUser
            ? SideMenu(
                name: 'aaaa',
                // name: state.user!.name,
                colorShoping: const Color.fromARGB(221, 241, 13, 13))
            : const Text('');
      }),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(221, 241, 13, 13),
        title: Text('Compras',
            style: GoogleFonts.lobster(
              textStyle: const TextStyle(
                letterSpacing: 3,
                fontSize: 30,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            )),
      ),
      body: const Center(
        child: Text('SalesScreen'),
      ),
    );
  }
}
