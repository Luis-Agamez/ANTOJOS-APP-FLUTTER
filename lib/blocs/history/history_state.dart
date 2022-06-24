part of 'history_bloc.dart';

class HistoryState extends Equatable {
  final bool existsProducts;
  final List<Product> products;
  final String idFavorite;

  const HistoryState(
      {this.existsProducts = false,
      this.idFavorite = '',
      this.products = const []});

  HistoryState copyWith(
          {bool? existsProducts,
          String? idFavorite,
          List<Product>? products}) =>
      HistoryState(
        existsProducts: existsProducts ?? this.existsProducts,
        idFavorite: idFavorite ?? this.idFavorite,
        products: products ?? this.products,
      );

  @override
  List<Object> get props => [existsProducts, products, idFavorite];
}
