import 'package:client/core/providers/current_song_notifer.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils/convert_color.dart';
import 'package:client/features/home/models/song.dart';
import 'package:client/features/home/repositories/home_repositories.dart';
import 'package:client/features/home/viewModels/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MusicPlayer extends ConsumerWidget {
  const MusicPlayer({super.key, required this.song});

  final Song song;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songState = ref.watch(currentSongStateProvider);

    return Scaffold(
        body: Hero(
            tag: song.id,
            child: Material(
                child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          if (song.hexCode.startsWith('#'))
                            hexToColor(song.hexCode)
                          else if (song.hexCode != '')
                            parseColorObjectString(song.hexCode)
                          else
                            Pallete.whiteColor,
                          Pallete.backgroundColor,
                        ])),
                    child: SafeArea(
                        child: SingleChildScrollView(
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(children: [
                                  // Back button
                                  Container(
                                      alignment: Alignment.topLeft,
                                      child: IconButton(
                                          iconSize: 30,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Pallete.whiteColor))),

                                  // Album art
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.35,
                                    width: double.infinity,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                          image: NetworkImage(song.thumbnail),
                                          fit: BoxFit.cover),
                                    ),
                                  ),

                                  // Song info
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                song.name,
                                                style: const TextStyle(
                                                  color: Pallete.whiteColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                song.artist,
                                                style: const TextStyle(
                                                  color: Pallete.subtitleText,
                                                  fontSize: 14,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                        ref
                                            .watch(getFavoriteSongsProvider)
                                            .when(
                                              data: (favoriteSongs) {
                                                final isFavorited =
                                                    favoriteSongs.any((f) =>
                                                        f.song.id == song.id);
                                                return IconButton(
                                                  onPressed: () async {
                                                    await ref
                                                        .read(
                                                            homeRemoteReponsitoriesProvider)
                                                        .favoriteSong(
                                                            song, ref);
                                                    ref.invalidate(
                                                        getFavoriteSongsProvider);
                                                  },
                                                  icon: Icon(
                                                    isFavorited
                                                        ? Icons.favorite
                                                        : Icons
                                                            .favorite_outline,
                                                    color: Pallete.whiteColor,
                                                  ),
                                                );
                                              },
                                              loading: () => IconButton(
                                                  onPressed: () async {
                                                    await ref
                                                        .read(
                                                            homeRemoteReponsitoriesProvider)
                                                        .favoriteSong(
                                                            song, ref);
                                                    ref.invalidate(
                                                        getFavoriteSongsProvider);
                                                  },
                                                  icon: const Icon(
                                                      Icons.favorite_outline,
                                                      color:
                                                          Pallete.whiteColor)),
                                              error: (_, __) => IconButton(
                                                  onPressed: () async {
                                                    await ref
                                                        .read(
                                                            homeRemoteReponsitoriesProvider)
                                                        .favoriteSong(
                                                            song, ref);
                                                    ref.invalidate(
                                                        getFavoriteSongsProvider);
                                                  },
                                                  icon: const Icon(
                                                      Icons.favorite_outline,
                                                      color:
                                                          Pallete.whiteColor)),
                                            ),
                                      ],
                                    ),
                                  ),
                                  // Progress slider
                                  StreamBuilder(
                                      stream: ref
                                          .read(
                                              currentSongStateProvider.notifier)
                                          .state
                                          .player
                                          ?.positionStream,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const SizedBox.shrink();
                                        }

                                        final position = snapshot.data;
                                        final duration = ref
                                            .read(currentSongStateProvider
                                                .notifier)
                                            .state
                                            .player!
                                            .duration;

                                        double sliderValue = 0.0;
                                        if (duration != null &&
                                            position != null) {
                                          sliderValue =
                                              position.inMilliseconds /
                                                  duration.inMilliseconds;
                                        }

                                        return Column(
                                          children: [
                                            Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: SliderTheme(
                                                  data: SliderThemeData(
                                                    trackShape:
                                                        const RoundedRectSliderTrackShape(),
                                                    trackHeight: 4,
                                                    thumbShape:
                                                        const RoundSliderThumbShape(
                                                            enabledThumbRadius:
                                                                10),
                                                    activeTrackColor: Pallete
                                                        .whiteColor
                                                        .withValues(alpha: 0.5),
                                                    inactiveTrackColor: Pallete
                                                        .whiteColor
                                                        .withValues(
                                                            alpha: 0.117),
                                                    thumbColor:
                                                        Pallete.whiteColor,
                                                  ),
                                                  child: Slider(
                                                      min: 0,
                                                      max: 1,
                                                      value: sliderValue,
                                                      onChanged: (value) {
                                                        sliderValue = value;
                                                      },
                                                      onChangeEnd: (value) {
                                                        ref
                                                            .read(
                                                                currentSongStateProvider
                                                                    .notifier)
                                                            .seekTo(value);
                                                      }),
                                                )),
                                            // Time labels
                                            Container(
                                                padding: const EdgeInsets.only(
                                                    left: 12, right: 16),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                        '${position!.inMinutes < 10 ? '0${position.inMinutes}' : position.inMinutes} : ${(position.inSeconds % 60) < 10 ? '0${position.inSeconds % 60}' : position.inSeconds % 60}',
                                                        style: const TextStyle(
                                                            color: Pallete
                                                                .subtitleText,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300)),
                                                    const Spacer(),
                                                    Text(
                                                        '${duration!.inMinutes < 10 ? '0${duration.inMinutes}' : duration.inMinutes} : ${(duration.inSeconds % 60) < 10 ? '0${duration.inSeconds % 60}' : duration.inSeconds % 60}',
                                                        style: const TextStyle(
                                                            color: Pallete
                                                                .subtitleText,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300)),
                                                  ],
                                                ))
                                          ],
                                        );
                                      }),

                                  // Main controls
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30),
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        // Calculate available width for each button
                                        final availableWidth =
                                            constraints.maxWidth;
                                        final buttonWidth =
                                            (availableWidth - 40) /
                                                5; // 40px for spacing
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                              width: buttonWidth,
                                              child: IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                      Icons.shuffle,
                                                      color:
                                                          Pallete.whiteColor)),
                                            ),
                                            SizedBox(
                                              width: buttonWidth,
                                              child: IconButton(
                                                  iconSize: 40,
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                      Icons.skip_previous,
                                                      color:
                                                          Pallete.whiteColor)),
                                            ),
                                            SizedBox(
                                                width: buttonWidth,
                                                child: Center(
                                                  child: Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                      color: Pallete.whiteColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                    child: IconButton(
                                                      iconSize: 35,
                                                      onPressed: () async {
                                                        await ref
                                                            .read(
                                                                currentSongStateProvider
                                                                    .notifier)
                                                            .pauseSong();
                                                      },
                                                      icon: songState.isPlaying
                                                          ? const Icon(
                                                              Icons.pause,
                                                              color: Pallete
                                                                  .cardColor)
                                                          : const Icon(
                                                              Icons.play_arrow,
                                                              color: Pallete
                                                                  .cardColor),
                                                    ),
                                                  ),
                                                )),
                                            SizedBox(
                                              width: buttonWidth,
                                              child: IconButton(
                                                  iconSize: 40,
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                      Icons.skip_next,
                                                      color:
                                                          Pallete.whiteColor)),
                                            ),
                                            SizedBox(
                                              width: buttonWidth,
                                              child: IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(Icons.repeat,
                                                      color:
                                                          Pallete.whiteColor)),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),

                                  // Bottom controls
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                                Icons.cast_connected,
                                                color: Pallete.whiteColor)),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                                Icons.playlist_play,
                                                color: Pallete.whiteColor)),
                                      ],
                                    ),
                                  ),
                                ]))))))));
  }
}
