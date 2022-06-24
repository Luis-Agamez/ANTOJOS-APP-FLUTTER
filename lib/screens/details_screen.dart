import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import '../blocs/favorites/favorites_bloc.dart';
import '../blocs/trolley/trolley_bloc.dart';
import '../models/product.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final favoriteBloc = BlocProvider.of<FavoritesBloc>(context);
    final trolleyBloc = BlocProvider.of<TrolleyBloc>(context);
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
        // backgroundColor: const Color.fromARGB(195, 241, 13, 13),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(195, 241, 13, 13),
          title: Text('Antojos',
              style: GoogleFonts.lobster(
                textStyle: const TextStyle(
                  letterSpacing: 3,
                  fontSize: 30,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Hero(
                tag: product.id,
                child: Image.network(
                  '${product.images}',
                  height: 350,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 10),
              Container(
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
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.all(20),
                child: Column(children: <Widget>[
                  const _ShopeName(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  product.title,
                                  style: const TextStyle(fontSize: 24),
                                ),
                                const SizedBox(height: 25),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(product.description,
                                      style: const TextStyle(fontSize: 18)),
                                ),
                                const SizedBox(height: 10),
                                Text(product.slug,
                                    style: const TextStyle(fontSize: 16)),
                              ]),
                        ),
                        ClipPath(
                          clipper: PricerClipper(),
                          child: Container(
                            alignment: Alignment.topCenter,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            height: 66,
                            width: 65,
                            color: const Color.fromARGB(221, 241, 13, 13),
                            child: Text('${product.price}',
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CartCounter(price: product.price),
                      HardButtom(
                        favoriteBloc: favoriteBloc,
                        product: product,
                        like: favoriteBloc.state.isFavorite,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(right: 16),
                            child: TextButton(
                              onPressed: () async {
                                double items = trolleyBloc.state.items;
                                //TODO Trolley
                                final resp = await trolleyBloc.sendFavorite(
                                    items, product.price, product.id);

                                var snackBar = SnackBar(
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    title: '¡Mensaje!',
                                    message: resp.toUpperCase(),
                                    contentType: ContentType.success,
                                  ),
                                );

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              child: const Icon(
                                  Icons.add_shopping_cart_outlined,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  size: 32),
                            ),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(221, 241, 13, 13),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color.fromARGB(221, 241, 13, 13),
                                ))),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 50,
                            child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(221, 241, 13, 13),
                                    ),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ))),
                                onPressed: () {},
                                child: Text(
                                  'Comprar Ahora'.toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                          ),
                        )
                      ],
                    ),
                  )
                ]),
              )
            ],
          ),
        ));
  }
}

class HardButtom extends StatelessWidget {
  final bool like;

  const HardButtom({
    Key? key,
    required this.favoriteBloc,
    required this.product,
    required this.like,
  }) : super(key: key);

  final FavoritesBloc favoriteBloc;
  final Product product;

  @override
  Widget build(BuildContext context) {
    final favoriteBloc = BlocProvider.of<FavoritesBloc>(context);
    return like
        ? LikeButton(
            isLiked: true,
            onTap: (isLiked) async {
              final id = favoriteBloc.state.idFavorite;
              print(id);
              favoriteBloc.removeFavorite(id);
              return false;
            },
            likeBuilder: (bool isLiked) {
              return Icon(
                Icons.favorite,
                color: isLiked
                    ? const Color.fromARGB(221, 241, 13, 13)
                    : Colors.grey,
                size: 32,
              );
            })
        : LikeButton(onTap: (isLiked) async {
            final resp = await favoriteBloc.sendFavorite(product.id);
            var snackBar = SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: '¡Mensaje!',
                message: resp.toUpperCase(),
                contentType: ContentType.success,
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            favoriteBloc.removeFavorit();
            return true;
          }, likeBuilder: (bool isLiked) {
            return Icon(
              Icons.favorite,
              color: isLiked
                  ? const Color.fromARGB(221, 241, 13, 13)
                  : Colors.grey,
              size: 32,
            );
          });
  }
}

class _ShopeName extends StatelessWidget {
  const _ShopeName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: const <Widget>[
      Icon(
        Icons.location_on,
        color: Colors.grey,
      ),
      SizedBox(width: 7),
      Text('Antojos')
    ]);
  }
}

class PricerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double ignoreHeight = 20;
    path.lineTo(0, size.height - ignoreHeight);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, size.height - ignoreHeight);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CartCounter extends StatefulWidget {
  final int price;
  const CartCounter({Key? key, required this.price}) : super(key: key);

  @override
  State<CartCounter> createState() => _CartCounterState(price);
}

class _CartCounterState extends State<CartCounter> {
  double numOfItems = 1 / 2;
  final int price;
  _CartCounterState(this.price);
  @override
  Widget build(BuildContext context) {
    final trolleyBloc = BlocProvider.of<TrolleyBloc>(context);
    print(trolleyBloc.state.items);
    double getTotal = numOfItems * price;
    return Row(children: <Widget>[
      _BuildOutlineButton(
          icon: Icons.remove,
          press: () {
            if (numOfItems > 0.5) {
              setState(() {
                numOfItems = numOfItems - 1 / 2;
                trolleyBloc.setItems(numOfItems);
              });
            }
          }),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text((() {
          if (numOfItems > 1 / 2) {
            return numOfItems.toString().padLeft(2, '0');
          }
          return "1/2";
        })(), style: Theme.of(context).textTheme.headline6),
      ),
      _BuildOutlineButton(
          icon: Icons.add,
          press: () {
            setState(() {
              numOfItems = numOfItems + 1 / 2;
              trolleyBloc.setItems(numOfItems);
            });
          }),
      Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Total:\$ $getTotal',
              style: Theme.of(context).textTheme.headline6,
            ),
          ))
    ]);
  }
}

class _BuildOutlineButton extends StatelessWidget {
  final IconData icon;
  final Function() press;
  const _BuildOutlineButton({
    Key? key,
    required this.icon,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 40,
        height: 32,
        child: OutlinedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(221, 241, 13, 13)),
                padding: MaterialStateProperty.all(
                  EdgeInsets.zero,
                ),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13)))),
            onPressed: press,
            child:
                Icon(icon, color: const Color.fromARGB(255, 255, 255, 255))));
  }
}
