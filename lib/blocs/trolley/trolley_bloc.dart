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
import '../../models/trolley_response.dart';
import '../order/order_bloc.dart';

part 'trolley_event.dart';
part 'trolley_state.dart';

class TrolleyBloc extends Bloc<TrolleyEvent, TrolleyState> {
  final OrderBloc orderBloc;
  late List<Product> products = [];
  late List<Response> trolley = [];
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
    on<SetIdItemsEvent>((event, emit) {
      emit(state.copyWith(idItems: event.idItems));
    });

    on<SetListAmountEvent>((event, emit) {
      emit(state.copyWith(listAmount: event.listAmount));
    });
    on<CleanEvent>((event, emit) {
      emit(const TrolleyState());
    });
  }

  Future<bool> getTrolley() async {
    final token = await _storage.read(key: 'token');
    late List<String> idItems = [];

    final uri = Uri.parse('${Environment.apiUrl}/trolley/get');

    final resp = await http.get(uri,
        headers: {'Content-Type': 'application/json', 'x-token': '$token'});

    if (resp.statusCode == 200) {
      late List<OderItem> orderItems = [];
      late List<int> listAmount = [];
      late List<int> sTotal = [];
      int total = 0;
      final productResponse = TrolleyResponse.fromJson(resp.body);
      trolley = productResponse.response;
      add(SetTrolleyEvent(trolley));

      for (int i = 0; i < trolley.length; i++) {
        total += trolley[i].total;
        listAmount.add(trolley[i].items);
        final data = {
          'title': trolley[i].pid.title,
          "description": trolley[i].pid.description,
          "img": trolley[i].pid.images,
          "inStock": trolley[i].pid.description,
          "price": trolley[i].total.toString(),
          "size": '1'
        };
        final it = jsonEncode(data);
        final item = OderItem.fromJson(it);

        orderItems.add(item);
        idItems.add(trolley[i].id);
        sTotal.add(trolley[i].total);

        orderBloc.setData(orderItems, sTotal, total, trolley.length);
      }

      add(SetIdItemsEvent(idItems));
      add(SetTotalEvent(total));
      setListAmount(listAmount);
      return true;
    } else {}

    return false;
  }

  sendItem(String title, String description, String images, int price) {
    late List<OderItem> orderItems = [];
    late List<int> sTotal = [];
    int total = 0;
    total += price;

    final data = {
      'title': title,
      "description": description,
      "img": images,
      "inStock": description,
      "price": price.toString(),
      "size": '1'
    };
    final it = jsonEncode(data);
    final item = OderItem.fromJson(it);

    orderItems.add(item);
    sTotal.add(price);
    orderBloc.setData(orderItems, sTotal, total, products.length);
  }

  Future<String> sendFavorite(int items, int price, String pid) async {
    final total = price;
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

  void removeItems(List<String> idItems) async {
    final token = await _storage.read(key: 'token');
    final data = {'idOfItems': idItems};

    final uri = Uri.parse('${Environment.apiUrl}/trolley/delete');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json', 'x-token': '$token'},
    );
    print(resp.body);
    // final body = AddFavoritesResponse.fromJson(resp.body);
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

  void setListAmount(List<int> listAmount) {
    add(SetListAmountEvent(listAmount));
  }

  void clearData() {
    add(CleanEvent());
  }

  bool isOlder(int total) {
    if (total <= 0) {
      return true;
    } else {
      return false;
    }
  }
}
