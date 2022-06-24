part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SetSearchEvent extends SearchEvent {
  final List<Product> products;
  const SetSearchEvent(this.products);
}

class ClearSearchEvent extends SearchEvent {}
