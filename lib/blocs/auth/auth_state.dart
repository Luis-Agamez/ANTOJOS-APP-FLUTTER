part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool existsUser;
  final User? user;

  const AuthState({this.existsUser = false, this.user = null});

  AuthState copyWith({
    final bool? existsUser,
    final User? user,
  }) =>
      AuthState(
          existsUser: existsUser ?? this.existsUser, user: user ?? this.user);

  @override
  List<Object?> get props => [existsUser, user];
}
