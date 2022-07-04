import 'package:antojos_app/blocs/blocs.dart';
import 'package:antojos_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => AuthBloc()),
    BlocProvider(create: (context) => UserBloc()),
    BlocProvider(create: (context) => ProductBloc()),
    BlocProvider(create: (context) => SearchBloc()),
    BlocProvider(create: (context) => FavoritesBloc()),
    BlocProvider(create: (context) => HistoryBloc()),
    BlocProvider(create: (context) => OrderBloc()),
    BlocProvider(
        create: (context) =>
            TrolleyBloc(orderBloc: BlocProvider.of<OrderBloc>(context))),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Antojos App',
      initialRoute: 'loading',
      routes: appRoutes,
    );
  }
}
