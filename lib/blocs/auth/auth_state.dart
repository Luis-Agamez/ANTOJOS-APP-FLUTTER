part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool existsUser;
  final bool loading;
  final User? user;

  const AuthState(
      {this.existsUser = false, this.loading = false, this.user = null});

  AuthState copyWith({
    final bool? existsUser,
    final bool? loading,
    final User? user,
  }) =>
      AuthState(
          existsUser: existsUser ?? this.existsUser,
          loading: loading ?? this.loading,
          user: user ?? this.user);

  @override
  List<Object?> get props => [existsUser, user, loading];
}
