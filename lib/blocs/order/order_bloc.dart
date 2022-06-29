import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../global/environment.dart';
import '../../models/delete_favorite_response.dart';
import '../../models/orderResponse.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final _storage = const FlutterSecureStorage();

  OrderBloc() : super(const OrderState()) {
    on<SetOrderEvent>((event, emit) {
      emit(state.copyWith(existOrder: true, order: event.order));
    });

    on<SetOrderItems>(((event, emit) {
      emit(state.copyWith(orderItems: event.orderItems));
    }));

    on<SetSubTotal>(((event, emit) {
      emit(state.copyWith(subTotal: event.subTotal));
    }));

    on<SetTotals>(((event, emit) {
      emit(state.copyWith(totals: event.totals));
    }));

    on<SetNumberOfItems>(((event, emit) {
      emit(state.copyWith(numberOfItems: event.numberOfItems));
    }));

    on<SetTotal>(((event, emit) {
      emit(state.copyWith(total: event.total));
    }));

    on<CleanerData>(((event, emit) {
      emit(state.copyWith(total: 0, totals: 0, numberOfItems: 0));
    }));
  }

  Future<bool> getOrders() async {
    final token = await _storage.read(key: 'token');

    final uri = Uri.parse('${Environment.apiUrl}/order/get');

    final resp = await http.get(uri,
        headers: {'Content-Type': 'application/json', 'x-token': '$token'});

    if (resp.statusCode == 200) {
      final orderResponse = OrderResponse.fromJson(resp.body);
      final order = orderResponse.orders;
      add(SetOrderEvent(order));
      return true;
    } else {}

    return false;
  }

  void clearData() {
    add(CleanerData());
  }

  void setData(List<OderItem> oderItems, List<int> subTotal, int totals,
      int numberOfItems) {
    add(SetOrderItems(oderItems));
    add(SetSubTotal(subTotal));
    add(SetTotals(totals));
    add(SetNumberOfItems(numberOfItems));
  }

  void removeItem(String id) async {
    final token = await _storage.read(key: 'token');

    final uri = Uri.parse('${Environment.apiUrl}/order/$id');

    final resp = await http.delete(uri,
        headers: {'Content-Type': 'application/json', 'x-token': '$token'});
    final deleteResponse = DeleteFavoritesResponse.fromJson(resp.body);
    print(resp.body);
    // if (resp.statusCode == 200) {
    // } else {}
  }

  Future<bool> sendOrder(List<OderItem> orderItems, List<int> subTotal,
      int totals, int numberOfItems, List<int> listAmount) async {
    final token = await _storage.read(key: 'token');
    final data = {
      'oderItems': orderItems,
      'subTotal': subTotal,
      "numberOfItems": numberOfItems,
      "totals": totals,
      "amount": listAmount
    };
    final uri = Uri.parse('${Environment.apiUrl}/order/new');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json', 'x-token': '$token'},
    );
    print(resp.body);

    if (resp.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> sendOrderItem(List<OderItem> orderItems, int subTotal,
      int numberOfItems, int total, int amount) async {
    final token = await _storage.read(key: 'token');
    final data = {
      'oderItems': orderItems,
      'subTotal': subTotal,
      "numberOfItems": numberOfItems,
      "totals": total,
      "amount": [amount]
    };
    final uri = Uri.parse('${Environment.apiUrl}/order/new');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json', 'x-token': '$token'},
    );
    print(resp.body);

    if (resp.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  void setTotalMid(int total) {
    print(total);
    add(SetTotal(total));
  }
}
