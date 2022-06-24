import 'package:flutter/material.dart';
import '../services/constants.dart';

class CardTrolley extends StatelessWidget {
  const CardTrolley({
    Key? key,
    required this.image,
    required this.text,
    required this.title,
    required this.tag,
    required this.price,
    required this.id,
    required this.inStock,
  }) : super(key: key);

  final String id;
  final String image;
  final String text;
  final String title;
  final String tag;
  final String price;
  final int inStock;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: Hero(tag: id, child: Image.network(image)),
              // Image.network(image),
            ),
            const SizedBox(width: defaultPadding),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tag,
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: defaultPadding / 2),
                    child: Text(
                      text,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Cantidad :  $inStock',
                        style:
                            const TextStyle(color: primaryColor, fontSize: 17),
                      ),
                      const SizedBox(width: 15),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          '\$ $price',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
