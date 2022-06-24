import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ConfigBody extends StatelessWidget {
  const ConfigBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 40,
        ),
        const SizedBox(
          height: 20,
        ),
        ProfileMenu(
          icon: "assets/icons/User Icon.svg",
          text: 'Editar Nombre'.toUpperCase(),
        ),
        ProfileMenu(
          icon: "assets/icons/Mail.svg",
          text: 'Editar Correo'.toUpperCase(),
        ),
        ProfileMenu(
          icon: "assets/icons/Location point.svg",
          text: 'Editar Direccion'.toUpperCase(),
        ),
        ProfileMenu(
          icon: "assets/icons/Lock.svg",
          text: 'Cambiar Contraseña'.toUpperCase(),
        )
      ],
    );
  }
}

class ProfileMenu extends StatelessWidget {
  final String text;
  final String icon;
  final Function()? onPressed;
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
              padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xFFF5F6F9))),
          onPressed: () {},
          child: Row(children: <Widget>[
            SvgPicture.asset(
              icon,
              width: 22,
              color: const Color.fromARGB(221, 241, 13, 13),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: Text(
              text,
              style: const TextStyle(color: Colors.grey, fontSize: 20),
            )),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[800],
            )
          ])),
    );
  }
}
