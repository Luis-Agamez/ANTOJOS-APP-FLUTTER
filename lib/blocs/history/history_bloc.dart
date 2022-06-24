import 'dart:convert';
import 'package:antojos_app/models/product.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../global/environment.dart';
import '../../models/delete_favorite_response.dart';
import '../../models/favorites_response.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  late List<Product> products;
  final _storage = const FlutterSecureStorage();

  HistoryBloc() : super(const HistoryState()) {
    on<SetHistoryEvent>((event, emit) {
      emit(state.copyWith(existsProducts: true, products: event.products));
    });
  }

  Future<bool> getHistory() async {
    final token = await _storage.read(key: 'token');

    final uri = Uri.parse('${Environment.apiUrl}/history/get');

    final resp = await http.get(uri,
        headers: {'Content-Type': 'application/json', 'x-token': '$token'});

    if (resp.statusCode == 200) {
      final favoritesResponse = FavoritesResponse.fromJson(resp.body);
      products = favoritesResponse.products;
      print('Historial');
      print(resp);
      add(SetHistoryEvent(products));
      if (products.isNotEmpty) {
        return true;
      }
    } else {}
    return false;
  }

  Future<bool> sendProduct(String pid) async {
    final token = await _storage.read(key: 'token');
    final data = {'pid': pid};
    print(token);

    final uri = Uri.parse('${Environment.apiUrl}/history/create');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json', 'x-token': '$token'},
    );
    print(resp.body);
    // final body = FavoritesResponse.fromJson(resp.body);
    // print(body);
    if (resp.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  void removeHistory(String id) async {
    final token = await _storage.read(key: 'token');

    final uri = Uri.parse('${Environment.apiUrl}/history/$id');

    final resp = await http.delete(uri,
        headers: {'Content-Type': 'application/json', 'x-token': '$token'});
    final deleteResponse = DeleteFavoritesResponse.fromJson(resp.body);
    print(resp.body);
    // if (resp.statusCode == 200) {
    // } else {}
  }
}
