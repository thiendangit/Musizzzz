import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:client/core/failure/failure.dart';
import 'package:client/features/home/models/song.dart';
import 'package:client/features/home/repositories/home_repositories.dart';
import 'package:fpdart/fpdart.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  late final HomeRemoteReponsitories _homeRemoteRepo;

  @override
  AsyncValue? build() {
    _homeRemoteRepo = ref.watch(homeRemoteReponsitoriesProvider);
    return null;
  }

  Future<Either<AppFailure, Song>> uploadSong(SongCreate song) async {
    state = const AsyncValue.loading();

    final result = await _homeRemoteRepo.uploadSong(song, ref);

    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (song) => state = AsyncValue.data(song),
    );
    return result;
  }
}
