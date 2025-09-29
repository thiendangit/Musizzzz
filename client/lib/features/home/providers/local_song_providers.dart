import 'package:client/features/home/models/song.dart';
import 'package:client/features/home/repositories/home_local_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_song_providers.g.dart';

@riverpod
Future<List<Song>> getLocalSongs(Ref ref) async {
  final localRepo = ref.watch(homeLocalRepositoriesProvider);
  return localRepo.loadSongs();
}

@riverpod
class LocalSongNotifier extends _$LocalSongNotifier {
  @override
  Future<List<Song>> build() async {
    final localRepo = ref.watch(homeLocalRepositoriesProvider);
    return localRepo.loadSongs();
  }

  Future<void> saveSong(Song song) async {
    final localRepo = ref.watch(homeLocalRepositoriesProvider);
    localRepo.saveSong(song);
    ref.invalidateSelf();
  }

  Future<void> deleteSong(String songId) async {
    final localRepo = ref.watch(homeLocalRepositoriesProvider);
    localRepo.deleteSong(songId);
    ref.invalidateSelf();
  }

  bool isSongSaved(String songId) {
    final localRepo = ref.watch(homeLocalRepositoriesProvider);
    return localRepo.isSongSaved(songId);
  }
}
