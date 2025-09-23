import 'package:client/core/providers/current_song_notifer.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils/convert_color.dart';
import 'package:client/features/home/widgets/music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MusicSlab extends ConsumerWidget {
  const MusicSlab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songState = ref.watch(currentSongStateProvider);

    if (songState.song == null) {
      return const SizedBox.shrink();
    }

    final currentSong = songState.song!;
    final isPlaying = songState.isPlaying;

    // Handle both hex string and Color object string formats
    Color backgroundColor;
    if (currentSong.hexCode.startsWith('#')) {
      backgroundColor = hexToColor(currentSong.hexCode);
    } else {
      backgroundColor = parseColorObjectString(currentSong.hexCode);
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MusicPlayer(song: currentSong)));
      },
      child: Stack(
        children: [
          Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: backgroundColor,
              ),
              child: Row(
                children: [
                  Hero(
                      tag: currentSong.id,
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          image: DecorationImage(
                              image: NetworkImage(currentSong.thumbnail),
                              fit: BoxFit.cover),
                        ),
                      )),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(currentSong.name,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(currentSong.artist,
                          style: const TextStyle(
                              color: Pallete.subtitleText, fontSize: 12)),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_outline),
                  ),
                  IconButton(
                    onPressed: () async {
                      await ref
                          .read(currentSongStateProvider.notifier)
                          .pauseSong();
                    },
                    icon: isPlaying
                        ? const Icon(Icons.pause_outlined)
                        : const Icon(Icons.play_arrow_outlined),
                  ),
                ],
              )),
          Positioned(
              bottom: 0,
              child: Container(
                height: 2,
                width: MediaQuery.of(context).size.width / 2,
                color: Pallete.whiteColor,
              ))
        ],
      ),
    );
  }
}
