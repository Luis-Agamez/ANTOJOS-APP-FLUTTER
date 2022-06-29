import 'package:flutter/material.dart';

import '../theme/theme.dart';

class data_input extends StatelessWidget {
  const data_input({
    Key? key,
    required this.textController,
    required this.minimum,
    required this.placeholder,
    required this.subTitle,
    required this.type,
  }) : super(key: key);

  final TextEditingController textController;
  final TextInputType type;
  final String placeholder;
  final String subTitle;
  final int minimum;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: const Color.fromARGB(221, 241, 13, 13),
      keyboardType: type,
      controller: textController,
      validator: (value) {
        if (value == null) {
          return "Este Campo es requerido";
        }
        return value.length < minimum
            ? "Este campo  requiere mas de $minimum caracteres"
            : null;
      },
      decoration: decoration(subTitle, placeholder),
    );
  }
}
