import 'dart:convert';

import 'package:antojos_app/models/login_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../global/environment.dart';
import '../../models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late User user;
  final _storage = FlutterSecureStorage();

  AuthBloc() : super(const AuthState()) {
    // TODO: implement event handler
    on<ActiveUser>((event, emit) =>
        emit(state.copyWith(existsUser: true, user: event.user)));

    on<CleanUser>(
        (event, emit) => emit(state.copyWith(existsUser: false, user: null)));
  }

  Future<bool> login(String email, String password) async {
    late User user;
    final data = {'email': email, 'password': password};

    final uri = Uri.parse('${Environment.apiUrl}/auth/login');

    final resp = await http.post(uri,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    print(resp.body);
    if (resp.statusCode == 200) {
      print(resp.body);
      final loginResponse = LoginResponse.fromJson(resp.body);
      user = loginResponse.user;
      await _savedToken(loginResponse.token);
      add(ActiveUser(user));
      print(user);
      return true;
    } else {
      return false;
    }
  }

  Future register(String name, String email, String password) async {
    final data = {'name': name, 'email': email, 'password': password};

    final uri = Uri.parse('${Environment.apiUrl}/auth/new');

    final resp = await http.post(uri,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    print(resp);
    if (resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(resp.body);
      user = loginResponse.user;
      print(user);
      await _savedToken(loginResponse.token);
      add(ActiveUser(user));
      return true;
    } else {
      final resBody = jsonDecode(resp.body);
      return resBody['ok'];
    }
  }

  logout<Void>() async {
    await _storage.delete(key: 'token');
    add(CleanUser());
  }

  Future<bool> idLogggedIn() async {
    final token = await _storage.read(key: 'token');

    final uri = Uri.parse('${Environment.apiUrl}/auth/renew');

    final resp = await http.get(uri,
        headers: {'Content-Type': 'application/json', 'x-token': '$token'});

    if (resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(resp.body);
      user = loginResponse.user;
      print(user);
      add(ActiveUser(user));
      await _savedToken(loginResponse.token);
      return true;
    } else {
      logout();
      return false;
    }
  }

  Future _savedToken(String token) async {
    // Write value
    return await _storage.write(key: 'token', value: token);
  }
}
