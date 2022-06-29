import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/user/user_bloc.dart';
import 'bottom_red.dart';
import 'data_input.dart';

class FormData extends StatefulWidget {
  final String textPhone;
  final String textCity;
  final String textDistrict;
  final String textReference;
  final bool register;
  const FormData(
      {super.key,
      required this.textPhone,
      required this.textCity,
      required this.textDistrict,
      required this.textReference,
      required this.register});

  @override
  State<FormData> createState() => FormState(this.textPhone, this.textCity,
      this.textDistrict, this.textReference, this.register);
}

class FormState extends State<FormData> {
  final _formKey = GlobalKey<FormState>();
  final String textPhone;
  final String textCity;
  final String textDistrict;
  final String textReference;
  final bool register;
  late String cellPhoneNumber;
  late String address;

  FormState(this.textPhone, this.textCity, this.textDistrict,
      this.textReference, this.register);

  @override
  Widget build(BuildContext context) {
    late AuthBloc authBloc;
    late UserBloc userBloc;

    authBloc = BlocProvider.of<AuthBloc>(context);
    userBloc = BlocProvider.of<UserBloc>(context);
    final phone = TextEditingController(text: textPhone);
    final city = TextEditingController(text: textCity);
    final district = TextEditingController(text: textDistrict);
    final reference = TextEditingController(text: textReference);

    return Form(
      child: Column(
        children: [
          const SizedBox(height: 50),
          data_input(
            textController: phone,
            minimum: 3,
            placeholder: 'Ingrese su Telefono',
            subTitle: 'Telefono',
            type: TextInputType.number,
          ),
          const SizedBox(height: 30),
          data_input(
            textController: city,
            minimum: 3,
            placeholder: 'Ingrese la Ciudad o Municipio',
            subTitle: 'Ciudad',
            type: TextInputType.text,
          ),
          const SizedBox(height: 30),
          data_input(
            textController: district,
            minimum: 3,
            placeholder: 'Ingrese el Barrio o localidad',
            subTitle: 'Barrio',
            type: TextInputType.text,
          ),
          const SizedBox(height: 30),
          data_input(
            textController: reference,
            minimum: 3,
            placeholder: 'Ingrese una referencia adicional',
            subTitle: 'Referencia',
            type: TextInputType.text,
          ),
          const SizedBox(height: 40),
          BottomRed(
              text: 'Confirmar',
              onPressed: register
                  ? () async {
                      final state = userBloc.state;
                      // FocusScope.of(context).unfocus();
                      final registerOk = await authBloc.register(
                          state.name,
                          state.lastName,
                          state.email,
                          state.password,
                          phone.text.trim(),
                          city.text.trim(),
                          district.text.trim(),
                          reference.text.trim());
                      if (registerOk) {
                        print('register success');
                        Navigator.pushReplacementNamed(context, 'home');
                      } else {
                        print(registerOk);
                      }
                    }
                  : () async {
                      final user = authBloc.state.user;
                      FocusScope.of(context).unfocus();
                      final registerOk = await authBloc.updatedLocation(
                          phone.text.trim(),
                          city.text.trim(),
                          district.text.trim(),
                          reference.text.trim());
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
                        return ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar);
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

                        return ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar);
                      }
                    }),
        ],
      ),
    );
  }
}
