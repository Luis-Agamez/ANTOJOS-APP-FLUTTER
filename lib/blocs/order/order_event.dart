part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class SetOrderEvent extends OrderEvent {
  final List<Order> order;
  const SetOrderEvent(this.order);
}

class SetOrderItems extends OrderEvent {
  final List<OderItem> orderItems;
  const SetOrderItems(this.orderItems);
}

class SetSubTotal extends OrderEvent {
  final List<int> subTotal;
  const SetSubTotal(this.subTotal);
}

class SetTotals extends OrderEvent {
  final int totals;
  const SetTotals(this.totals);
}

class SetNumberOfItems extends OrderEvent {
  final int numberOfItems;
  const SetNumberOfItems(this.numberOfItems);
}

class CleanerData extends OrderEvent {}
