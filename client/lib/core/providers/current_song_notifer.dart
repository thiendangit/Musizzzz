import 'package:client/features/home/models/song.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_song_notifer.g.dart';

@Riverpod(keepAlive: true)
class CurrentSongNotifier extends _$CurrentSongNotifier {
  @override
  Song? build() {
    return null;
  }

  setSong(Song song) {
    state = song;
  }

  clearSong() {
    state = null;
  }
}
