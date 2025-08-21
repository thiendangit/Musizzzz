import 'dart:convert';

import 'package:client/core/constants/server.dart';
import 'package:client/core/failure/failure.dart';
import 'package:client/features/auth/models/auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'auth_remote_reponsitories.g.dart';

@riverpod
AuthRemoteReponsitories authRemoteReponsitories(Ref ref) {
  return AuthRemoteReponsitories();
}

class AuthRemoteReponsitories {
  var baseUrl = '127.0.0.1:8000/auth';

  Future<Either<AppFailure, User>> signUp(UserCreate user) async {
    try {
      var response = await http.post(Uri.parse('${Server.URL}/auth/signup/'),
          body: jsonEncode({
            'username': user.username,
            'email': user.email,
            'password': user.password,
          }),
          headers: {'content-type': 'application/json'});

      var responseDecode = (jsonDecode(response.body) as Map<String, dynamic>);

      if (response.statusCode == 200) {
        return Right(User.fromMap(responseDecode));
      } else {
        return Left(AppFailure(responseDecode['detail']));
      }
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, Auth>> signIn(UserLogin user) async {
    try {
      var response = await http.post(Uri.parse('${Server.URL}/auth/login/'),
          body: jsonEncode({
            'email': user.email,
            'password': user.password,
          }),
          headers: {'content-type': 'application/json'});

      var responseDecode = (jsonDecode(response.body) as Map<String, dynamic>);

      if (response.statusCode == 200) {
        return Right(Auth.fromMap(responseDecode));
      } else {
        return Left(AppFailure(responseDecode['detail']));
      }
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, Auth>> getCurrentUser(String token) async {
    try {
      var response = await http.post(Uri.parse('${Server.URL}/auth/'),
          headers: {'content-type': 'application/json', 'x-auth-token': token});

      var responseDecode = (jsonDecode(response.body) as Map<String, dynamic>);

      if (response.statusCode == 200) {
        return Right(Auth.fromMap(responseDecode));
      } else {
        return Left(AppFailure(responseDecode['detail']));
      }
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
