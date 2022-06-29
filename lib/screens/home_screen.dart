import 'package:antojos_app/services/constants.dart';
import 'package:antojos_app/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/favorites/favorites_bloc.dart';
import '../blocs/history/history_bloc.dart';
import '../blocs/order/order_bloc.dart';
import '../blocs/product/product_bloc.dart';
import '../blocs/trolley/trolley_bloc.dart';
import '../delegate/delegates.dart';
import '../models/user.dart';
import '../widgets/card_view.dart';
import '../widgets/skeleton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ProductBloc productBloc;
  late FavoritesBloc favoriteBloc;
  late HistoryBloc historyBloc;
  late OrderBloc orderBloc;
  late TrolleyBloc trolleyBloc;
  late bool _isLoading;

  @override
  void initState() {
    _isLoading = true;
    // Future.delayed(const Duration(seconds: 2), () {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });
    productBloc = BlocProvider.of<ProductBloc>(context);
    favoriteBloc = BlocProvider.of<FavoritesBloc>(context);
    orderBloc = BlocProvider.of<OrderBloc>(context);
    trolleyBloc = BlocProvider.of<TrolleyBloc>(context);
    productBloc.getProducts();
    favoriteBloc.getFavorites();
    orderBloc.getOrders();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late AuthBloc authBloc;
    late ProductBloc productBloc;
    authBloc = BlocProvider.of<AuthBloc>(context);
    productBloc = BlocProvider.of<ProductBloc>(context);
    final favoriteBloc = BlocProvider.of<FavoritesBloc>(context);
    print(productBloc.state.products.length);
    return Scaffold(
        drawer: BlocBuilder<AuthBloc, AuthState>(builder: (_, state) {
          return state.existsUser
              ? SideMenu(
                  name: state.user!.name,
                  colorHome: const Color.fromARGB(221, 241, 13, 13))
              : const Text('');
        }),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(221, 241, 13, 13),
          title: Text('Antojos',
              style: GoogleFonts.lobster(
                textStyle: const TextStyle(
                  letterSpacing: 3,
                  fontSize: 30,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              )),
          actions: <Widget>[
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      showSearch(
                          context: context, delegate: SearchProductDelegate());
                    },
                    icon: const Icon(Icons.search_sharp),
                    iconSize: 30),
                const SizedBox(width: 20),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'trolley');
                    },
                    icon: const Icon(Icons.shopping_cart_checkout_outlined),
                    iconSize: 30)
              ],
            )
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            child: BlocBuilder<ProductBloc, ProductState>(builder: (_, state) {
              return state.existsProducts
                  ? ListView.separated(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          favoriteBloc.verifyFavorite(
                              favoriteBloc.products, state.products[index].id);
                          trolleyBloc.orderBloc.clearData();
                          trolleyBloc.sendItem(state.products[index]);
                          trolleyBloc.clearData();
                          Navigator.pushNamed(context, 'details',
                              arguments: state.products[index]);
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
                      separatorBuilder: (context, index) => const Divider(
                          height: defaultPadding, color: Colors.black87),
                    )
                  : ListView.separated(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) => const Skeleton(),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: defaultPadding),
                    );
            })));
  }
}

class InformationUser extends StatelessWidget {
  final User user;

  const InformationUser({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: double.infinity,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('General',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Divider(),
          ListTile(title: Text('Name : ${user.name}')),
          const Divider(),
        ],
      ),
    );
  }
}
