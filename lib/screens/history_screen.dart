import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/history/history_bloc.dart';
import '../services/constants.dart';
import '../widgets/card_view.dart';
import '../widgets/side_menu.dart';
import '../widgets/skeleton.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late bool _isLoading;
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final historyBloc = BlocProvider.of<HistoryBloc>(context);
    return Scaffold(
        drawer: BlocBuilder<AuthBloc, AuthState>(builder: (_, state) {
          return state.existsUser
              ? SideMenu(
                  name: state.user!.name,
                  colorHistory: const Color.fromARGB(221, 241, 13, 13),
                )
              : const Text('');
        }),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(221, 241, 13, 13),
          title: Text('Historial',
              style: GoogleFonts.lobster(
                textStyle: const TextStyle(
                  letterSpacing: 3,
                  fontSize: 30,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              )),
        ),
        body: FutureBuilder(
            future: historyBloc.getHistory(),
            builder: (context, snapshot) {
              if (snapshot.data == true) {
                return BlocBuilder<HistoryBloc, HistoryState>(
                  builder: (_, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding, vertical: defaultPadding),
                      child: state.existsProducts
                          ? ListView.separated(
                              itemCount: state.products.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, 'details',
                                      arguments: state.products[index]);
                                },
                                child: Dismissible(
                                  key: UniqueKey(),
                                  background: Container(
                                      color: const Color.fromARGB(
                                          221, 241, 13, 13)),
                                  onDismissed: (dismissDirection) {
                                    //TODO Clean Favorite
                                    historyBloc.removeHistory(
                                        state.products[index].idFavorite);
                                  },
                                  child: CardView(
                                    id: state.products[index].id,
                                    price: '${state.products[index].price}',
                                    tag: state.products[index].slug,
                                    title: state.products[index].title,
                                    text: state.products[index].description,
                                    image: '${state.products[index].images}',
                                  ),
                                ),
                              ),
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                      height: defaultPadding,
                                      color: Colors.black87),
                            )
                          : ListView.separated(
                              itemCount: state.products.length,
                              itemBuilder: (context, index) => const Skeleton(),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: defaultPadding),
                            ),
                    );
                  },
                );
              } else {
                return Center(
                    child: Lottie.network(
                        'https://assets5.lottiefiles.com/packages/lf20_uqfbsoei.json'));
              }
            }));
  }
}
