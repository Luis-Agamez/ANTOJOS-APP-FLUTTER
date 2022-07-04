import 'package:antojos_app/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomRed extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  const BottomRed({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (_, state) {
      return MaterialButton(
        elevation: 2,
        hoverElevation: 5,
        onPressed: state.loading ? null : onPressed,
        child: Container(
          width: double.infinity,
          height: 55,
          decoration: BoxDecoration(
              color: state.loading
                  ? const Color.fromARGB(221, 121, 120, 120)
                  : const Color.fromARGB(221, 241, 13, 13),
              borderRadius: BorderRadius.circular(32)),
          child: Center(
              child: Text(
            text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                letterSpacing: 2,
                fontFamily: 'Lobster'),
          )),
        ),
      );
    });
  }
}
