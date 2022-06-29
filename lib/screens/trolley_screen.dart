import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/order/order_bloc.dart';
import '../blocs/trolley/trolley_bloc.dart';
import '../services/constants.dart';
import '../widgets/bottom_red.dart';
import '../widgets/card_trolley.dart';
import '../widgets/side_menu.dart';
import '../widgets/skeleton.dart';

class TrolleyScreen extends StatelessWidget {
  const TrolleyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late bool _isLoading;
    final trolleyBloc = BlocProvider.of<TrolleyBloc>(context);
    final orderBloc = BlocProvider.of<OrderBloc>(context);
    return Scaffold(
        drawer: BlocBuilder<AuthBloc, AuthState>(builder: (_, state) {
          return state.existsUser
              ? SideMenu(
                  name: state.user!.name,
                  colorFavorite: const Color.fromARGB(221, 241, 13, 13))
              : const Text('');
        }),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(221, 241, 13, 13),
          title: Text('Carrito',
              style: GoogleFonts.lobster(
                textStyle: const TextStyle(
                  letterSpacing: 3,
                  fontSize: 30,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              )),
        ),
        bottomNavigationBar:
            BlocBuilder<TrolleyBloc, TrolleyState>(builder: (_, state) {
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              height: 174,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, -15),
                        blurRadius: 20,
                        color: const Color(0xDDDADADA).withOpacity(0.15))
                  ]),
              child: state.total > 0
                  ? Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total :'.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '\$ ${state.total}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Divider(color: Colors.grey, height: 10),
                        const SizedBox(
                          height: 20,
                        ),
                        BottomRed(
                          text: 'Comprar ahora',
                          onPressed: () {
                            orderBloc.sendOrder(
                                orderBloc.state.orderItems,
                                orderBloc.state.subTotal,
                                orderBloc.state.totals,
                                orderBloc.state.numberOfItems,
                                state.listAmount);

                            trolleyBloc.removeItems(trolleyBloc.state.idItems);
                            Navigator.pushNamed(context, 'confirm');
                          },
                        )
                      ],
                    )
                  : const Text(''));
        }),
        body: FutureBuilder(
            future: trolleyBloc.getTrolley(),
            builder: (context, snapshot) {
              if (snapshot.data == true) {
                return BlocBuilder<TrolleyBloc, TrolleyState>(
                  builder: (_, state) {
                    return state.total > 0
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultPadding,
                                vertical: defaultPadding),
                            child: state.existsProducts
                                ? ListView.separated(
                                    itemCount: state.products.length,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                      onTap: () {
                                        trolleyBloc.orderBloc.clearData();
                                        Navigator.pushNamed(
                                            context, 'detailstrolley',
                                            arguments: state.products[index]);
                                        trolleyBloc
                                            .sendItem(state.products[index]);
                                      },
                                      child: CardTrolley(
                                        id: state.products[index].id,
                                        price: '${state.products[index].price}',
                                        tag: state.products[index].slug,
                                        title: state.products[index].title,
                                        text: state.products[index].description,
                                        image:
                                            '${state.products[index].images}',
                                        inStock: state.products[index].inStock,
                                      ),
                                    ),
                                    separatorBuilder: (context, index) =>
                                        const Divider(
                                            height: defaultPadding,
                                            color: Colors.black87),
                                  )
                                : ListView.separated(
                                    itemCount: state.products.length,
                                    itemBuilder: (context, index) =>
                                        const Skeleton(),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: defaultPadding),
                                  ),
                          )
                        : Center(
                            child: Lottie.network(
                                'https://assets9.lottiefiles.com/packages/lf20_L4w8VH.json'));
                  },
                );
              } else {
                return Center(
                    child: Lottie.network(
                        'https://assets9.lottiefiles.com/packages/lf20_L4w8VH.json'));
              }
            }));
  }
}
