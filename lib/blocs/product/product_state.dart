part of 'product_bloc.dart';

class ProductState extends Equatable {
  final bool existsProducts;
  final List<Product> products;

  const ProductState({this.existsProducts = false, this.products = const []});

  ProductState copyWith({bool? existsProducts, List<Product>? products}) =>
      ProductState(
        existsProducts: existsProducts ?? this.existsProducts,
        products: products ?? this.products,
      );

  @override
  List<Object> get props => [existsProducts, products];
}
