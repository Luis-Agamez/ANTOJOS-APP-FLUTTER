part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class SetProductEvent extends ProductEvent {
  final List<Product> products;
  const SetProductEvent(this.products);
}
