import 'package:antojos_app/screens/screens.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'login': (_) => const LoginScreen(),
  'register': (_) => const RegisterScreen(),
  'home': (_) => const HomeScreen(),
  'loading': (_) => const LoadingScreen(),
  'sales': (_) => const SalesScreen(),
  'settings': (_) => const SettingsScreen(),
  'favorites': (_) => const FavoritesScreen(),
  'history': (_) => const HistoryScreen(),
  'information': (_) => const InfoScreen(),
  'trolley': (_) => const TrolleyScreen(),
  'routes': (_) => const SearchScreen(),
  'details': (_) => const DetailsScreen(),
};
