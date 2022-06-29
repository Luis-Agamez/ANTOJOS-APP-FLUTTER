part of 'trolley_bloc.dart';

class TrolleyState extends Equatable {
  final bool existsProducts;
  final List<Product> products;
  final List<int> listAmount;
  final List<String> idItems;
  final double items;
  final int total;

  bool get isOlder => total >= 0;

  const TrolleyState(
      {this.existsProducts = false,
      this.total = 0,
      this.items = 0,
      this.products = const [],
      this.idItems = const [],
      this.listAmount = const []});

  TrolleyState copyWith(
          {bool? existsProducts,
          int? total,
          double? items,
          List<Product>? products,
          List<String>? idItems,
          List<int>? listAmount}) =>
      TrolleyState(
        existsProducts: existsProducts ?? this.existsProducts,
        total: total ?? this.total,
        items: items ?? this.items,
        products: products ?? this.products,
        idItems: idItems ?? this.idItems,
        listAmount: listAmount ?? this.listAmount,
      );

  @override
  List<Object> get props =>
      [existsProducts, products, total, items, idItems, listAmount];
}
