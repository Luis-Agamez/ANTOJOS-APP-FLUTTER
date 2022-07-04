part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class ActiveUser extends AuthEvent {
  final User user;
  const ActiveUser(this.user);
}

class CleanUser extends AuthEvent {}

class AutenticationActive extends AuthEvent {}

class AutenticationDesactive extends AuthEvent {}
