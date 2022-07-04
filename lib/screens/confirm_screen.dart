import 'package:antojos_app/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/bottom_red.dart';

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<AuthBloc>(context).state;
    final user = state.user;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Column(
                children: const <Widget>[
                  Text('Confirmacion de informacion Personal',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          height: 1.5)),
                  Text(
                    'Confirma tu informacion personal para que podamos enviar tu pedido',
                    textAlign: TextAlign.start,
                    style: TextStyle(letterSpacing: 1),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'Email:'.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    state.existsUser ? user!.email : '',
                    style: const TextStyle(fontSize: 18, letterSpacing: 1),
                  )
                ],
              ),
              const Divider(height: 2, color: Colors.black),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'Resive:'.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    state.existsUser ? '${user!.name}   ${user.lastName} ' : '',
                    style: const TextStyle(fontSize: 18, letterSpacing: 1),
                  )
                ],
              ),
              const Divider(height: 2, color: Colors.black),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'Numero de Telefono:'.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    state.existsUser ? '${user!.phoneNumber}' : '',
                    style: const TextStyle(fontSize: 18, letterSpacing: 1),
                  )
                ],
              ),
              const Divider(height: 2, color: Colors.black),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Direccion'.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        state.existsUser
                            ? '${user!.reference},${user.district},${user.city} '
                            : '',
                        style: const TextStyle(fontSize: 18, letterSpacing: 1),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(221, 241, 13, 13),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ))),
                        onPressed: () {
                          Navigator.pushNamed(context, 'userconfig');
                        },
                        child: Text(
                          'Cambiar Direccion'.toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )),
                  ]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 200,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, -15),
                  blurRadius: 20,
                  color: const Color(0xDDDADADA).withOpacity(0.15))
            ]),
        child: BottomRed(
          text: 'Comfirmar',
          onPressed: () {
            Navigator.pushNamed(context, 'home');
          },
        ),
      ),
    );
  }
}
