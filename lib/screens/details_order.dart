import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/order/order_bloc.dart';
import '../models/orderResponse.dart';

class DetailsOrder extends StatelessWidget {
  const DetailsOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Order order = ModalRoute.of(context)!.settings.arguments as Order;
    final orderBloc = BlocProvider.of<OrderBloc>(context);
    return Scaffold(
      // backgroundColor: const Color.fromARGB(221, 241, 13, 13),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(221, 241, 13, 13),
        title: Text('Pedido',
            style: GoogleFonts.lobster(
              textStyle: const TextStyle(
                letterSpacing: 3,
                fontSize: 30,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text(
                  'Nº Pedido:',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  order.id,
                  style: const TextStyle(fontSize: 16),
                )
              ]),
              const SizedBox(height: 10),
              Row(children: const [
                Text(
                  'Detalles',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text('')
              ]),
              const Divider(height: 2, color: Colors.black87),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text(
                  'Productos referenciados',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '${order.numberOfItems}',
                  style: const TextStyle(fontSize: 16),
                )
              ]),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: order.oderItems.length,
                  itemBuilder: (_, i) => Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('${order.amount[i]}',
                                style: const TextStyle(fontSize: 16)),
                            const SizedBox(width: 15),
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              child: SizedBox(
                                height: 80,
                                width: 80,
                                child: FadeInImage(
                                  image: NetworkImage(order.oderItems[i].img),
                                  placeholder: const AssetImage(
                                      'assets/gifts/hamburger.gif'),
                                ),
                                // Image.network(image),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Text(order.oderItems[i].title,
                                style: const TextStyle(fontSize: 16)),
                            const SizedBox(width: 10),
                            Container(
                              child: order.numberOfItems == 1
                                  ? Text('${order.totals}',
                                      style: const TextStyle(fontSize: 16))
                                  : Text(order.oderItems[i].price,
                                      style: const TextStyle(fontSize: 16)),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
              const Divider(height: 2, color: Colors.black87),
              const SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text(
                  'Pedido Resivido:',
                  style: TextStyle(fontSize: 16),
                ),
                CheckOrder(order: order, status: order.received)
              ]),
              const SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text(
                  'Pedido en Preparacion:',
                  style: TextStyle(fontSize: 16),
                ),
                CheckOrder(order: order, status: order.preparing)
              ]),
              const SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text(
                  'Pedido Listo:',
                  style: TextStyle(fontSize: 16),
                ),
                CheckOrder(order: order, status: order.ready)
              ]),
              const SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text(
                  'Pedido Entegado:',
                  style: TextStyle(fontSize: 16),
                ),
                CheckOrder(order: order, status: order.delivered),
              ]),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, -15),
                  blurRadius: 20,
                  color: const Color(0xDDDADADA).withOpacity(0.15))
            ]),
        height: 280,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            // const _ShopeName(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Subtotal'.toUpperCase(),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            Column(
                              children: order.subTotal
                                  .map((e) => Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const SizedBox(
                                              width: 260,
                                            ),
                                            Text(
                                              '$e',
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ]))
                                  .toList(),
                            ),
                            const Divider(height: 5, color: Colors.black87),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total :'.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 160,
                                ),
                                Text(
                                  '\$ ${order.totals}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            const Divider(color: Colors.grey, height: 10),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: order.preparing
                    ? Row(
                        children: [
                          const SizedBox(width: 20),
                          SizedBox(
                            width: 320,
                            height: 50,
                            child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(221, 173, 170, 170),
                                    ),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ))),
                                onPressed: null,
                                child: Text(
                                  'Cancelar pedido'.toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          const SizedBox(width: 20),
                          SizedBox(
                            width: 320,
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
                                onPressed: () {
                                  // trolleyBloc.removeItem(product.idFavorite);
                                  Navigator.pushNamed(context, 'home');
                                  orderBloc.removeItem(order.id);
                                },
                                child: Text(
                                  'Cancelar pedido'.toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                          ),
                        ],
                      ))
          ]),
        ),
      ),
    );
  }
}

class CheckOrder extends StatelessWidget {
  const CheckOrder({
    Key? key,
    required this.order,
    required this.status,
  }) : super(key: key);

  final Order order;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return status
        ? Icon(
            Icons.check_circle,
            color: Colors.green[900],
          )
        : Icon(
            Icons.check_circle,
            color: Colors.grey[500],
          );
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
