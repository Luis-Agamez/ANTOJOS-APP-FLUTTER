part of 'trolley_bloc.dart';

class TrolleyState extends Equatable {
  final bool existsProducts;
  final List<Product> products;
  final double items;
  final int total;

  const TrolleyState(
      {this.existsProducts = false,
      this.total = 0,
      this.items = 0,
      this.products = const []});

  TrolleyState copyWith(
          {bool? existsProducts,
          int? total,
          double? items,
          List<Product>? products}) =>
      TrolleyState(
        existsProducts: existsProducts ?? this.existsProducts,
        total: total ?? this.total,
        items: items ?? this.items,
        products: products ?? this.products,
      );

  @override
  List<Object> get props => [existsProducts, products, total, items];
}
