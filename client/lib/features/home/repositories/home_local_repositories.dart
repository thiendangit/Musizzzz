import 'package:client/features/home/models/song.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_local_repositories.g.dart';

@riverpod
HomeLocalRepositories homeLocalRepositories(Ref ref) {
  return HomeLocalRepositories();
}

class HomeLocalRepositories {
  late final Box<dynamic> _box;

  HomeLocalRepositories() {
    _box = Hive.box('songs');
  }

  void saveSong(Song song) {
    _box.put(song.id, song.toMap());
  }

  List<Song> loadSongs() {
    List<Song> songs = [];
    for (var songId in _box.keys) {
      final songData = _box.get(songId) as Map<dynamic, dynamic>;
      songs.add(Song.fromMap(Map<String, dynamic>.from(songData)));
    }
    return songs;
  }

  void deleteSong(String songId) {
    _box.delete(songId);
  }

  bool isSongSaved(String songId) {
    return _box.containsKey(songId);
  }
}
