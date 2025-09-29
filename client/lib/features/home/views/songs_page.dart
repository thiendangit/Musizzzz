import 'package:client/core/providers/current_song_notifer.dart';
import 'package:client/features/home/providers/local_song_providers.dart';
import 'package:client/features/home/viewModels/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SongsPage extends ConsumerWidget {
  const SongsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(8, 8, 8,
            100), // Thêm padding bottom để tránh bị che bởi music player
        child: Column(
          children: [
            // Latest Songs Section
            const Text(
              'Latest Songs',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 260,
              child: ref.watch(getSongsProvider).when(
                    data: (songs) => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: songs.length,
                      itemBuilder: (context, index) {
                        final song = songs[index];
                        return GestureDetector(
                          onTap: () async {
                            await ref
                                .read(currentSongStateProvider.notifier)
                                .setSong(song, ref);
                          },
                          child: Container(
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
                          ),
                        );
                      },
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

            const SizedBox(height: 20),

            // My Library Section
            const Text(
              'My Library',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ref.watch(getLocalSongsProvider).when(
              data: (songs) {
                if (songs.isEmpty) {
                  return const SizedBox(
                    height: 200,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.music_note, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'No songs in library',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Play some songs to add them to your library',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Column(
                  children: songs.map((song) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(song.thumbnail),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                          song.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(song.artist),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                await ref
                                    .read(currentSongStateProvider.notifier)
                                    .setSong(song, ref);
                              },
                              icon: const Icon(Icons.play_arrow),
                            ),
                            IconButton(
                              onPressed: () async {
                                await ref
                                    .read(localSongNotifierProvider.notifier)
                                    .deleteSong(song.id);
                              },
                              icon: const Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
              error: (Object error, StackTrace stackTrace) {
                return SizedBox(
                  height: 200,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error, size: 48, color: Colors.red),
                        const SizedBox(height: 16),
                        Text('Error: $error'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => ref.refresh(getLocalSongsProvider),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                );
              },
              loading: () {
                return const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
