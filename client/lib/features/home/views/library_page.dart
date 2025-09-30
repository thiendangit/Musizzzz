import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/home/viewModels/home_view_model.dart';
import 'package:client/features/home/views/upload_song.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            _buildHeader(context),

            // Content Section
            Expanded(
              child: ref.watch(getFavoriteSongsProvider).when(
                    data: (favoriteSongs) =>
                        _buildContent(context, ref, favoriteSongs),
                    error: (error, stackTrace) => _buildErrorState(error),
                    loading: () => _buildLoadingState(),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your Library',
                style: TextStyle(
                  color: Pallete.whiteColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Pallete.cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () {
                    // TODO: Implement search functionality
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Pallete.whiteColor,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Your favorite songs and playlists',
            style: TextStyle(
              color: Pallete.subtitleText,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
      BuildContext context, WidgetRef ref, List<dynamic> favoriteSongs) {
    if (favoriteSongs.isEmpty) {
      return _buildEmptyState(context);
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
      itemCount: favoriteSongs.length + 1,
      itemBuilder: (context, index) {
        if (index == favoriteSongs.length) {
          return _buildUploadButton(context);
        } else {
          return _buildSongCard(context, ref, favoriteSongs[index]);
        }
      },
    );
  }

  Widget _buildSongCard(
      BuildContext context, WidgetRef ref, dynamic favoriteSong) {
    final song = favoriteSong.song;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // TODO: Navigate to music player
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Pallete.cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Pallete.borderColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Album Art
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(song.thumbnail),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Song Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        song.name,
                        style: const TextStyle(
                          color: Pallete.whiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        song.artist,
                        style: const TextStyle(
                          color: Pallete.subtitleText,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Action Buttons
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        // TODO: Implement play functionality
                      },
                      icon: const Icon(
                        Icons.play_arrow,
                        color: Pallete.whiteColor,
                        size: 24,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO: Implement more options
                      },
                      icon: const Icon(
                        Icons.more_vert,
                        color: Pallete.subtitleText,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UploadSongPage(),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Pallete.gradient1, Pallete.gradient2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Pallete.gradient1.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Pallete.whiteColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Pallete.whiteColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Upload New Song',
                        style: TextStyle(
                          color: Pallete.whiteColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Share your music with the world',
                        style: TextStyle(
                          color: Pallete.whiteColor.withOpacity(0.8),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Pallete.whiteColor,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Pallete.cardColor,
                borderRadius: BorderRadius.circular(60),
              ),
              child: const Icon(
                Icons.music_note_outlined,
                size: 60,
                color: Pallete.subtitleText,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No Favorite Songs Yet',
              style: TextStyle(
                color: Pallete.whiteColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Start by adding some songs to your library or upload your own music',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Pallete.subtitleText,
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            _buildUploadButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
      itemCount: 5,
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Pallete.cardColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Pallete.borderColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 16,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Pallete.borderColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 12,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Pallete.borderColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Pallete.errorColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Icon(
                Icons.error_outline,
                size: 40,
                color: Pallete.errorColor,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Something went wrong',
              style: TextStyle(
                color: Pallete.whiteColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Error: $error',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Pallete.subtitleText,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement retry functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Pallete.gradient1,
                foregroundColor: Pallete.whiteColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
