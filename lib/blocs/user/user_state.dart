part of 'user_bloc.dart';

class UserState extends Equatable {
  final String name;
  final String email;
  final String lastName;
  final String password;

  const UserState(
      {this.name = '',
      this.email = '',
      this.lastName = '',
      this.password = ''});

  UserState copyWith(
          {final String? name,
          final String? email,
          final String? lastName,
          final String? password}) =>
      UserState(
          name: name ?? this.name,
          email: email ?? this.email,
          lastName: lastName ?? this.lastName,
          password: password ?? this.password);

  @override
  List<Object> get props => [name, email, lastName, password];
}
