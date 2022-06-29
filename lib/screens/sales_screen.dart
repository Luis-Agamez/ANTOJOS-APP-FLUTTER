import 'package:antojos_app/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../blocs/order/order_bloc.dart';
import '../widgets/card_order.dart';
import '../widgets/side_menu.dart';
import '../widgets/skeleton.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({Key? key}) : super(key: key);

  get defaultPadding => null;

  @override
  Widget build(BuildContext context) {
    late AuthBloc authBloc;
    authBloc = BlocProvider.of<AuthBloc>(context);
    final orderBloc = BlocProvider.of<OrderBloc>(context);
    return Scaffold(
        drawer: BlocBuilder<AuthBloc, AuthState>(builder: (_, state) {
          return state.existsUser
              ? SideMenu(
                  name: state.user!.name,
                  // name: state.user!.name,
                  colorShoping: Color.fromARGB(221, 241, 13, 13))
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
        body: FutureBuilder(
            future: orderBloc.getOrders(),
            builder: (context, snapshot) {
              if (snapshot.data == true) {
                return BlocBuilder<OrderBloc, OrderState>(
                  builder: (_, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: state.existOrder
                          ? ListView.separated(
                              itemCount: state.order.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, 'detailsorder',
                                      arguments: state.order[index]);
                                },
                                child: Container(
                                    child:
                                        CardOrder(order: state.order[index])),
                              ),
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                      height: 16, color: Colors.black87),
                            )
                          : ListView.separated(
                              itemCount: state.order.length,
                              itemBuilder: (context, index) => const Skeleton(),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 16),
                            ),
                    );
                  },
                );
              } else {
                return Center(
                    child: Lottie.network(
                        'https://assets6.lottiefiles.com/packages/lf20_a20g35gn.json'));
              }
            }));
  }
}
