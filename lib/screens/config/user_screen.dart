import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../widgets/form_data.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<AuthBloc>(context).state.user;
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
              child: FormData(
                textPhone: '${user!.phoneNumber}',
                textCity: '${user.city}',
                textDistrict: '${user.district}',
                textReference: '${user.reference}',
                register: false,
              ))),
    );
  }
}
