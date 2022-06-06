import 'package:flutter/material.dart';
import '../services/constants.dart';

class CardView extends StatelessWidget {
  const CardView({
    Key? key,
    required this.image,
    required this.text,
    required this.title,
    required this.tag,
    required this.price,
    required this.id,
  }) : super(key: key);

  final String id;
  final String image;
  final String text;
  final String title;
  final String tag;
  final String price;

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
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(color: primaryColor),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding / 2),
                        child: CircleAvatar(
                          radius: 3,
                          backgroundColor: grayColor,
                        ),
                      ),
                      Text(
                        price,
                        style: TextStyle(color: grayColor),
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
