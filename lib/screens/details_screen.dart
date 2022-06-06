import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/product.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
        backgroundColor: const Color.fromARGB(221, 241, 13, 13),
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
        ),
        body: Column(
          children: <Widget>[
            Hero(
                tag: product.id,
                child: Image.network(
                  '${product.images}',
                  height: 350,
                  width: double.infinity,
                )),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: Column(children: <Widget>[
                  const _ShopeName(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
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
                                    style: const TextStyle(fontSize: 16))
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
                      CartCounter(),
                      Container(
                        child:
                            const Icon(Icons.heart_broken, color: Colors.white),
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(221, 241, 13, 13),
                            ),
                            color: const Color.fromARGB(221, 241, 13, 13),
                            shape: BoxShape.circle),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(right: 16),
                            child: const Icon(Icons.shopping_cart_outlined,
                                color: Color.fromARGB(221, 241, 13, 13),
                                size: 32),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color.fromARGB(221, 241, 13, 13),
                                ))),
                        Expanded(
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
              ),
            )
          ],
        ));
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
  CartCounter({Key? key}) : super(key: key);

  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  double numOfItems = 1 / 2;
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      _BuildOutlineButton(
          icon: Icons.remove,
          press: () {
            if (numOfItems > 0.5) {
              setState(() {
                numOfItems = numOfItems - 1 / 2;
              });
            }
          }),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          numOfItems.toString().padLeft(2, '0'),
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      _BuildOutlineButton(
          icon: Icons.add,
          press: () {
            setState(() {
              numOfItems = numOfItems + 1 / 2;
            });
          }),
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
                padding: MaterialStateProperty.all(
                  EdgeInsets.zero,
                ),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13)))),
            onPressed: press,
            child: Icon(icon)));
  }
}
