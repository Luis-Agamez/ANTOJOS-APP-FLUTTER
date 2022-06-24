part of 'trolley_bloc.dart';

abstract class TrolleyEvent extends Equatable {
  const TrolleyEvent();

  @override
  List<Object> get props => [];
}

class SetTrolleyEvent extends TrolleyEvent {
  final List<Product> products;
  const SetTrolleyEvent(this.products);
}

class SetTotalEvent extends TrolleyEvent {
  final int total;
  const SetTotalEvent(this.total);
}

class SetItemsEvent extends TrolleyEvent {
  final double items;
  const SetItemsEvent(this.items);
}
