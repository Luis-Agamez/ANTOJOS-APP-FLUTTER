import 'package:antojos_app/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../blocs/favorites/favorites_bloc.dart';
import '../services/constants.dart';
import '../widgets/card_view.dart';
import '../widgets/side_menu.dart';
import '../widgets/skeleton.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late bool _isLoading;
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final favoritesBloc = BlocProvider.of<FavoritesBloc>(context);
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
          title: const Text(
            'Favoritos',
            style: TextStyle(
              fontFamily: 'Lobster',
              letterSpacing: 3,
              fontSize: 30,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        body: FutureBuilder(
            future: favoritesBloc.getFavorites(),
            builder: (context, snapshot) {
              if (snapshot.data == true) {
                return BlocBuilder<FavoritesBloc, FavoritesState>(
                  builder: (_, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding, vertical: defaultPadding),
                      child: state.existsProducts
                          ? ListView.separated(
                              itemCount: state.products.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  favoritesBloc.verifyFavorite(
                                      favoritesBloc.products,
                                      state.products[index].id);
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
                                    favoritesBloc.removeFavorite(
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
                    child: Lottie.asset(
                        'assets/animations/43191-no-data-error.json'));
              }
            }));
  }
}
