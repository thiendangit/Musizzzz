import 'package:client/features/home/viewModels/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SongsPage extends ConsumerWidget {
  const SongsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const Text(
              'Latest Songs',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ref.watch(getSongsProvider).when(
                    data: (songs) => SizedBox(
                      height: 260,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: songs.length,
                        itemBuilder: (context, index) {
                          final song = songs[index];
                          return Container(
                            width: 150,
                            margin: const EdgeInsets.only(right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(song.thumbnail),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  song.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 5),
                                Text(song.artist),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    error: (Object error, StackTrace stackTrace) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error,
                                size: 48, color: Colors.red),
                            const SizedBox(height: 16),
                            Text('Error: $error'),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => ref.refresh(getSongsProvider),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    },
                    loading: () {
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
