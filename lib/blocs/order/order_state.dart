part of 'order_bloc.dart';

class OrderState extends Equatable {
  final bool existOrder;
  final List<Order> order;
  final List<OderItem> orderItems;
  final List<int> subTotal;
  final int totals;
  final int numberOfItems;
  final int total;

  const OrderState(
      {this.existOrder = false,
      this.order = const [],
      this.orderItems = const [],
      this.subTotal = const [],
      this.totals = 0,
      this.numberOfItems = 0,
      this.total = 0});

  OrderState copyWith(
          {bool? existOrder,
          List<Order>? order,
          List<OderItem>? orderItems,
          List<int>? subTotal,
          int? totals,
          int? numberOfItems,
          int? total}) =>
      OrderState(
        existOrder: existOrder ?? this.existOrder,
        order: order ?? this.order,
        orderItems: orderItems ?? this.orderItems,
        subTotal: subTotal ?? this.subTotal,
        totals: totals ?? this.totals,
        numberOfItems: numberOfItems ?? this.numberOfItems,
        total: total ?? this.total,
      );

  @override
  List<Object> get props =>
      [existOrder, order, orderItems, subTotal, totals, numberOfItems, total];
}
