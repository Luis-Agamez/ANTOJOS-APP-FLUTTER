part of 'search_bloc.dart';

class SearchState extends Equatable {
  final bool existsProducts;
  final List<Product> products;

  const SearchState({this.existsProducts = false, this.products = const []});

  SearchState copyWith({bool? existsProducts, List<Product>? products}) =>
      SearchState(
        existsProducts: existsProducts ?? this.existsProducts,
        products: products ?? this.products,
      );

  @override
  List<Object> get props => [existsProducts, products];
}
