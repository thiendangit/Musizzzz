import 'package:client/features/home/models/song.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentSongState {
  const CurrentSongState({this.song, required this.isPlaying, this.player});

  final Song? song;
  final bool isPlaying;
  final AudioPlayer? player;

  CurrentSongState copyWith(
      {Song? song, bool? isPlaying, AudioPlayer? player}) {
    return CurrentSongState(
      song: song ?? this.song,
      isPlaying: isPlaying ?? this.isPlaying,
      player: player ?? this.player,
    );
  }
}

class CurrentSongNotifier extends StateNotifier<CurrentSongState> {
  CurrentSongNotifier()
      : super(
            const CurrentSongState(song: null, isPlaying: false, player: null));

  final AudioPlayer? _player = AudioPlayer();

  // Play a new song
  setSong(Song song) async {
    try {
      // Show slab immediately with playing=true for instant icon update
      state = state.copyWith(song: song, isPlaying: true, player: _player);

      // Stop current song if playing
      if (_player?.playing == true) {
        await _player?.stop();
      }

      // Set new audio source
      await _player?.setAudioSource(
        AudioSource.uri(Uri.parse(song.songFile)),
      );

      // Start playing (do not await to avoid UI delay)
      // If it fails, we'll revert below in catch
      _player?.play();
    } catch (e) {
      state =
          const CurrentSongState(song: null, isPlaying: false, player: null);
    }
  }

  // Toggle play/pause
  pauseSong() async {
    final shouldPlay = !state.isPlaying;

    // Update UI first for instant icon change
    state = state.copyWith(isPlaying: shouldPlay);

    try {
      if (shouldPlay) {
        // Start playing; don't block UI
        _player?.play();
      } else {
        _player?.pause();
      }
    } catch (_) {
      // Revert on failure
      state = state.copyWith(isPlaying: !shouldPlay);
    }
  }

  // Stop and clear current song
  clearSong() async {
    state = const CurrentSongState(song: null, isPlaying: false, player: null);
    await _player?.stop();
    await _player?.dispose();
  }

  seekTo(double value) async {
    final totalMs = _player?.duration?.inMilliseconds ?? 0;
    final targetMs = (value * totalMs).toInt();
    await _player?.seek(Duration(milliseconds: targetMs));
  }
}

// Provider for current song + playing state
final currentSongStateProvider =
    StateNotifierProvider<CurrentSongNotifier, CurrentSongState>((ref) {
  return CurrentSongNotifier();
});
