part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class SetHistoryEvent extends HistoryEvent {
  final List<Product> products;
  const SetHistoryEvent(this.products);
}

class ClearHistory extends HistoryEvent {}
