import 'package:antojos_app/models/product.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../global/environment.dart';
import '../../models/product_response.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  late List<Product> products;
  final _storage = const FlutterSecureStorage();
  SearchBloc() : super(const SearchState()) {
    on<SetSearchEvent>((event, emit) {
      // TODO: implement event handler
      emit(state.copyWith(existsProducts: true, products: event.products));
    });

    on<ClearSearchEvent>((event, emit) {
      // TODO: implement event handler
      emit(SearchState());
    });
  }

  void getSearch(String tag) async {
    final token = await _storage.read(key: 'token');

    final uri = Uri.parse('${Environment.apiUrl}/product/$tag');
    print(uri);

    final resp = await http.get(uri,
        headers: {'Content-Type': 'application/json', 'x-token': '$token'});
    if (resp.statusCode == 200) {
      final productResponse = ProductResponse.fromJson(resp.body);
      products = productResponse.products;
      print(products.length);
      if (products.isNotEmpty) {
        add(SetSearchEvent(products));
      } else {
        add(ClearSearchEvent());
      }
    } else {}
  }
}
