import 'package:antojos_app/blocs/auth/auth_bloc.dart';
import 'package:antojos_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/product/product_bloc.dart';
import 'blocs/search/search_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => AuthBloc()),
    BlocProvider(create: (context) => ProductBloc()),
    BlocProvider(create: (context) => SearchBloc())
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
