import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:recipes/dto/APIResponseDTO.dart';
import 'package:recipes/dto/user/LoginRequestDTO.dart';
import 'package:recipes/dto/user/LoginResponseDTO.dart';
import 'package:recipes/dto/user/RegisterRequestDTO.dart';
import 'package:recipes/dto/user/RegisterResponseDTO.dart';
import 'package:recipes/models/index.dart';
import 'package:http/http.dart' as http;

abstract class UserRepository {
  Future<User> getUser();
  Future<String> authenticate({String username, String password});
  Future<String> register({String username, String password});
  Future<void> deleteToken();
  Future<void> persistToken(String token);
  Future<bool> hasToken();
}

class UserRepositoryImpl implements UserRepository {
  final _storage = FlutterSecureStorage();
  final _httpClient = http.Client();

  final _tokenKey = 'token';

  User _user;

  @override
  Future<User> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User(id: "abc"),
    );
  }

  @override
  Future<String> authenticate(
      {@required String username, @required String password}) async {
    final http.Response response = await _httpClient.post(
      "http://localhost:8080/api/public/user/login",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: LoginRequestDTO(username: username, password: password).toJson(),
    );

    if (response.statusCode != 200) {
      print('fetch -> Request failed with status: ${response.statusCode}.');
      throw Exception('failed');
    }

    APIResponseDTO apiResponseDTO = APIResponseDTO.fromJson(response.body);
    if (!apiResponseDTO.success) {
      print('fetch -> error:${apiResponseDTO.error}');
      throw Exception(apiResponseDTO.error);
    }

    LoginResponseDTO responseDTO =
        LoginResponseDTO.fromMap(apiResponseDTO.data);
    return responseDTO.token;
  }

  @override
  Future<String> register(
      {@required String username, @required String password}) async {
    final http.Response response = await _httpClient.post(
      "http://localhost:8080/api/public/user/register",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: RegisterRequestDTO(username: username, password: password).toJson(),
    );

    if (response.statusCode != 200) {
      print('fetch -> Request failed with status: ${response.statusCode}.');
      throw Exception('failed');
    }

    APIResponseDTO apiResponseDTO = APIResponseDTO.fromJson(response.body);
    if (!apiResponseDTO.success) {
      print('fetch -> error:${apiResponseDTO.error}');
      throw Exception(apiResponseDTO.error);
    }

    RegisterResponseDTO responseDTO =
        RegisterResponseDTO.fromMap(apiResponseDTO.data);
    return responseDTO.token;
  }

  @override
  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
    return;
  }

  @override
  Future<void> persistToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
    return;
  }

  @override
  Future<bool> hasToken() async {
    String token = await _storage.read(key: _tokenKey);
    return token != null && token.isNotEmpty;
  }
}

// class FakeUserRepositoryImpl implements UserRepository {
//   final _storage = FlutterSecureStorage();
//   final _httpClient = http.Client();

//   final _tokenKey = 'token';

//   User _user;

//   @override
//   Future<User> getUser() async {
//     if (_user != null) return _user;
//     return Future.delayed(
//       const Duration(milliseconds: 300),
//       () => _user = User(id: "abc"),
//     );
//   }

//   @override
//   Future<String> authenticate(
//       {@required String username, @required String password}) async {
//     final http.Response response = await _httpClient.post(
//       "http://localhost:8080/api/public/user/login",
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: LoginRequestDTO(username: username, password: password).toJson(),
//     );

//     if (response.statusCode != 200) {
//       print('fetch -> Request failed with status: ${response.statusCode}.');
//       throw Exception('failed');
//     }

//     APIResponseDTO apiResponseDTO = APIResponseDTO.fromJson(response.body);
//     if (!apiResponseDTO.success) {
//       print('fetch -> error:${apiResponseDTO.error}');
//       throw Exception(apiResponseDTO.error);
//     }

//     LoginResponseDTO responseDTO =
//         LoginResponseDTO.fromMap(apiResponseDTO.data);
//     return responseDTO.token;
//   }

//   @override
//   Future<String> register({String username, String password}) {
//     // TODO: implement register
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> deleteToken() async {
//     await _storage.delete(key: _tokenKey);
//     return;
//   }

//   @override
//   Future<void> persistToken(String token) async {
//     await _storage.write(key: _tokenKey, value: token);
//     return;
//   }

//   @override
//   Future<bool> hasToken() async {
//     String token = await _storage.read(key: _tokenKey);
//     return token != null && token.isNotEmpty;
//   }
// }
