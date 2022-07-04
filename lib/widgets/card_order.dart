import 'package:flutter/material.dart';
import '../models/orderResponse.dart';
import '../services/constants.dart';

class CardOrder extends StatelessWidget {
  const CardOrder({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: defaultPadding),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pedido No : ${order.id}',
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: defaultPadding / 2),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Productos refenciados:',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black)),
                          Text(
                            ' ${order.numberOfItems}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                        ]),
                  ),
                  Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Subtotal :',
                                style: TextStyle(color: Colors.black)),
                            Row(
                                children: order.subTotal
                                    .map((item) => Row(
                                          children: [
                                            const SizedBox(width: 5),
                                            Text('$item',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12))
                                          ],
                                        ))
                                    .toList()),
                          ]),
                      const SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total :',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(221, 241, 13, 13)),
                            ),
                            Text(
                              ' \$ ${order.totals} ',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ])
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
