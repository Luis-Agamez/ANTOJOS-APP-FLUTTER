import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../global/environment.dart';
import '../../models/add_favorite_response.dart';
import '../../models/delete_favorite_response.dart';
import '../../models/orderResponse.dart';
import '../../models/product.dart';
import '../../models/product_response.dart';
import '../order/order_bloc.dart';

part 'trolley_event.dart';
part 'trolley_state.dart';

class TrolleyBloc extends Bloc<TrolleyEvent, TrolleyState> {
  final OrderBloc orderBloc;
  late List<Product> products = [];
  final _storage = const FlutterSecureStorage();
  TrolleyBloc({required this.orderBloc}) : super(const TrolleyState()) {
    on<SetTrolleyEvent>((event, emit) {
      emit(state.copyWith(existsProducts: true, products: event.products));
    });
    on<SetTotalEvent>((event, emit) {
      emit(state.copyWith(total: event.total));
    });
    on<SetItemsEvent>((event, emit) {
      emit(state.copyWith(items: event.items));
    });
  }

  Future<bool> getTrolley() async {
    final token = await _storage.read(key: 'token');

    final uri = Uri.parse('${Environment.apiUrl}/trolley/get');

    final resp = await http.get(uri,
        headers: {'Content-Type': 'application/json', 'x-token': '$token'});

    if (resp.statusCode == 200) {
      late List<OderItem> orderItems = [];
      late List<int> sTotal = [];
      int total = 0;
      final productResponse = ProductResponse.fromJson(resp.body);
      products = productResponse.products;
      add(SetTrolleyEvent(products));

      for (int i = 0; i < products.length; i++) {
        total += products[i].price;

        // print(total);
        final data = {
          'title': products[i].title,
          "description": products[i].description,
          "img": products[i].images,
          "inStock": products[i].description,
          "price": products[i].price.toString(),
          "size": '1'
        };
        final it = jsonEncode(data);
        final item = OderItem.fromJson(it);

        orderItems.add(item);
        sTotal.add(products[i].price);

        orderBloc.setData(orderItems, sTotal, total, products.length);
      }

      add(SetTotalEvent(total));

      return true;
    } else {}

    return false;
  }

  sendItem(Product product) {
    late List<OderItem> orderItems = [];
    late List<int> sTotal = [];
    int total = 0;
    total += product.price;

    final data = {
      'title': product.title,
      "description": product.description,
      "img": product.images,
      "inStock": product.description,
      "price": product.price.toString(),
      "size": '1'
    };
    final it = jsonEncode(data);
    final item = OderItem.fromJson(it);

    orderItems.add(item);
    sTotal.add(product.price);

    orderBloc.setData(orderItems, sTotal, total, products.length);
  }

  Future<String> sendFavorite(double items, int price, String pid) async {
    final total = items * price;
    final token = await _storage.read(key: 'token');
    final data = {'items': items, 'total': total, 'pid': pid};

    final uri = Uri.parse('${Environment.apiUrl}/trolley/new');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json', 'x-token': '$token'},
    );
    print(resp.body);
    final body = AddFavoritesResponse.fromJson(resp.body);
    if (resp.statusCode == 200) {
      return body.msg;
    } else {
      return body.msg;
    }
  }

  void setItems(double items) {
    add(SetItemsEvent(items));
  }

  void removeItem(String id) async {
    final token = await _storage.read(key: 'token');

    final uri = Uri.parse('${Environment.apiUrl}/trolley/$id');

    final resp = await http.delete(uri,
        headers: {'Content-Type': 'application/json', 'x-token': '$token'});
    final deleteResponse = DeleteFavoritesResponse.fromJson(resp.body);
    print(resp.body);
    // if (resp.statusCode == 200) {
    // } else {}
  }
}
