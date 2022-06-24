part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class SetFavoritesEvent extends FavoritesEvent {
  final List<Product> products;
  const SetFavoritesEvent(this.products);
}

class SetIdFavorite extends FavoritesEvent {
  final String id;
  const SetIdFavorite(this.id);
}

class ClearIdFavorite extends FavoritesEvent {}

class SetFavorite extends FavoritesEvent {}

class ClearFevorite extends FavoritesEvent {}

class ClearFavoritesEvent extends FavoritesEvent {}
