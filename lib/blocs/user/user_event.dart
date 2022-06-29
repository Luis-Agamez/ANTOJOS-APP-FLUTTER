part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class SetDataEvent extends UserEvent {
  final String name;
  final String email;
  final String lastName;
  final String password;

  const SetDataEvent(this.name, this.email, this.lastName, this.password);
}
