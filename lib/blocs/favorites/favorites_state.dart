part of 'favorites_bloc.dart';

class FavoritesState extends Equatable {
  final bool existsProducts;
  final List<Product> products;
  final String idFavorite;
  final bool isFavorite;

  const FavoritesState(
      {this.existsProducts = false,
      this.isFavorite = false,
      this.idFavorite = '',
      this.products = const []});

  FavoritesState copyWith(
          {bool? existsProducts,
          bool? isFavorite,
          String? idFavorite,
          List<Product>? products}) =>
      FavoritesState(
        existsProducts: existsProducts ?? this.existsProducts,
        isFavorite: isFavorite ?? this.isFavorite,
        idFavorite: idFavorite ?? this.idFavorite,
        products: products ?? this.products,
      );

  @override
  List<Object> get props => [existsProducts, products, isFavorite, idFavorite];
}
