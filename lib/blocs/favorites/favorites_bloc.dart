import 'dart:convert';

import 'package:antojos_app/models/add_favorite_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import '../../global/environment.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../models/delete_favorite_response.dart';
import '../../models/favorites_response.dart';
import '../../models/product.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  late List<Product> products;
  final _storage = const FlutterSecureStorage();

  FavoritesBloc() : super(const FavoritesState()) {
    on<SetFavoritesEvent>((event, emit) {
      emit(state.copyWith(existsProducts: true, products: event.products));
    });

    on<SetFavorite>((event, emit) {
      emit(state.copyWith(isFavorite: true));
    });

    on<ClearFevorite>((event, emit) {
      emit(state.copyWith(isFavorite: false));
    });

    on<SetIdFavorite>((event, emit) {
      emit(state.copyWith(idFavorite: event.id));
    });
  }

  Future<bool> getFavorites() async {
    final token = await _storage.read(key: 'token');

    final uri = Uri.parse('${Environment.apiUrl}/favorites/get');

    final resp = await http.get(uri,
        headers: {'Content-Type': 'application/json', 'x-token': '$token'});
    if (resp.statusCode == 200) {
      final favoritesResponse = FavoritesResponse.fromJson(resp.body);
      products = favoritesResponse.products;
      print(products);
      add(SetFavoritesEvent(products));
      if (products.isNotEmpty) {
        return true;
      }
    } else {}
    return false;
  }

  Future<String> sendFavorite(String pid) async {
    final token = await _storage.read(key: 'token');
    final data = {'pid': pid};
    print(token);

    final uri = Uri.parse('${Environment.apiUrl}/favorites/create');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json', 'x-token': '$token'},
    );
    // print(resp.body);
    final body = AddFavoritesResponse.fromJson(resp.body);
    if (resp.statusCode == 200) {
      return body.msg;
    } else {
      return body.msg;
    }
  }

  void removeFavorite(String id) async {
    final token = await _storage.read(key: 'token');

    final uri = Uri.parse('${Environment.apiUrl}/favorites/$id');

    final resp = await http.delete(uri,
        headers: {'Content-Type': 'application/json', 'x-token': '$token'});
    final deleteResponse = DeleteFavoritesResponse.fromJson(resp.body);
    print(resp.body);
    // if (resp.statusCode == 200) {
    // } else {}
  }

  bool verifyFavorite(List<Product> products, String pid) {
    for (int i = 0; i < products.length; i++) {
      if (products[i].id == pid) {
        print(products[i].idFavorite);
        add(SetIdFavorite(products[i].idFavorite));
        add(SetFavorite());
        return true;
      } else {}
    }
    print('No lo encontre');
    add(ClearFevorite());
    return false;
  }

  void removeFavorit() {
    add(ClearFevorite());
  }
}
