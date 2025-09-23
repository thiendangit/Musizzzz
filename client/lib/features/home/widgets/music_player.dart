import 'package:client/features/home/models/song.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MusicPlayer extends ConsumerWidget {
  const MusicPlayer({super.key, this.song});

  final Song? song;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 24),
        child: Scaffold(
          body: Column(
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                      image: NetworkImage(song?.thumbnail ?? ''),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(song?.name ?? ''),
                        Text(song?.artist ?? ''),
                      ],
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_outline)),
                  ],
                ),
              ),
              Column(
                children: [
                  SliderTheme(
                      data: const SliderThemeData(
                        trackShape: RoundedRectSliderTrackShape(),
                        trackHeight: 4,
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 10),
                      ),
                      child: Slider(value: 0, onChanged: (value) {})),
                ],
              )
            ],
          ),
        ));
  }
}
