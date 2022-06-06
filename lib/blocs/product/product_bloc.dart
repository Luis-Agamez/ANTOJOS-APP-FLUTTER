import 'package:antojos_app/global/environment.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:antojos_app/models/product.dart';
import 'package:http/http.dart' as http;
import '../../models/product_response.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  late List<Product> products;
  final _storage = FlutterSecureStorage();
  ProductBloc() : super(const ProductState()) {
    on<SetProductEvent>((event, emit) {
      // TODO: implement event handler
      emit(state.copyWith(existsProducts: true, products: event.products));
    });
  }

  void getProducts() async {
    final token = await _storage.read(key: 'token');

    final uri = Uri.parse('${Environment.apiUrl}/product/get');

    final resp = await http.get(uri,
        headers: {'Content-Type': 'application/json', 'x-token': '$token'});
    if (resp.statusCode == 200) {
      final productResponse = ProductResponse.fromJson(resp.body);
      products = productResponse.products;
      add(SetProductEvent(products));
    } else {}
  }
}
