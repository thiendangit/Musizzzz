import 'dart:convert';

import 'package:client/core/constants/server.dart';
import 'package:client/core/failure/failure.dart';
import 'package:client/features/auth/repositories/auth_local_reponsitories.dart';
import 'package:client/features/home/models/song.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_repositories.g.dart';

@riverpod
HomeRemoteReponsitories homeRemoteReponsitories(Ref ref) {
  return HomeRemoteReponsitories();
}

class HomeRemoteReponsitories {
  Future<Either<AppFailure, Song>> uploadSong(SongCreate song, Ref ref) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${Server.URL}/song/upload-song'),
      );

      request.files.addAll([
        await http.MultipartFile.fromPath('song', song.song.path),
        await http.MultipartFile.fromPath('thumbnail', song.thumbnail.path)
      ]);
      request.fields['title'] = song.title;
      request.fields['artist'] = song.artist;
      request.fields['color'] = song.color;

      request.headers['content-type'] = 'multipart/form-data';

      request.headers['accept'] = 'application/json';

      final token = await ref.read(authLocalReponsitoriesProvider).getToken();

      if (token == null || token.isEmpty) {
        return Left(
            AppFailure('No authentication token found. Please login again.'));
      }

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['x-auth-token'] = token;

      final response = await request.send();

      final responseBody = await response.stream.bytesToString();
      var responseDecode = jsonDecode(responseBody) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return Right(Song.fromMap(responseDecode));
      } else {
        return Left(AppFailure(responseDecode['detail'] ?? 'Unknown error'));
      }
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
