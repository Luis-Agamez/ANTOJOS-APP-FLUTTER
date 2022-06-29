import 'dart:convert';

import 'package:antojos_app/models/login_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../global/environment.dart';
import '../../models/data_response.dart';
import '../../models/pass_response.dart';
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

  Future register(
      String name,
      String lastName,
      String email,
      String password,
      String phoneNumber,
      String city,
      String district,
      String reference) async {
    final data = {
      'name': name,
      'lastName': lastName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'city': city,
      'district': district,
      'reference': reference
    };

    final uri = Uri.parse('${Environment.apiUrl}/auth/new');

    final resp = await http.post(uri,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    print(resp.body);
    if (resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(resp.body);
      user = loginResponse.user;
      await _savedToken(loginResponse.token);
      add(ActiveUser(user));
      return true;
    } else {
      final resBody = jsonDecode(resp.body);
      return resBody['ok'];
    }
  }

  Future updatedLocation(String phoneNumber, String city, String district,
      String reference) async {
    final token = await _storage.read(key: 'token');
    final data = {
      'phoneNumber': phoneNumber,
      'city': city,
      'district': district,
      'reference': reference
    };

    final uri = Uri.parse('${Environment.apiUrl}/auth/user/config');

    final resp = await http.post(uri,
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json', 'x-token': '$token'});
    print(resp.body);
    if (resp.statusCode == 200) {
      print(resp.body);
      final loginResponse = DataResponse.fromJson(resp.body);
      user = loginResponse.user;
      add(ActiveUser(user));
      print(user);
      return true;
    } else {
      return false;
    }
  }

  Future updatedData(String name, String lastName, String email) async {
    final token = await _storage.read(key: 'token');
    final data = {
      'name': name,
      'lastName': lastName,
      'email': email,
    };

    final uri = Uri.parse('${Environment.apiUrl}/auth/user/config');

    final resp = await http.post(uri,
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json', 'x-token': '$token'});
    print(resp.body);
    if (resp.statusCode == 200) {
      print(resp.body);
      final loginResponse = DataResponse.fromJson(resp.body);
      user = loginResponse.user;
      add(ActiveUser(user));
      print(user);
      return true;
    } else {
      return false;
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

  Future<bool> passUpdated(String passOld, String passNew) async {
    final token = await _storage.read(key: 'token');
    final data = {'pass': passOld, 'newpass': passNew};

    final uri = Uri.parse('${Environment.apiUrl}/auth/user/pass');

    final resp = await http.post(uri,
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json', 'x-token': '$token'});
    final loginResponse = PassResponse.fromJson(resp.body);
    print(resp.body);
    if (loginResponse.ok == true) {
      return true;
    } else {
      return false;
    }
  }
}
