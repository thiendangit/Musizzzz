import 'package:client/features/home/views/library_page.dart';
import 'package:client/features/home/views/songs_page.dart';
import 'package:client/features/home/widgets/music_slab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const double iconSize = 24.0;

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;

  final pages = const [
    LibraryPage(),
    SongsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          pages[_selectedIndex],
          const Positioned(bottom: 0, child: MusicSlab())
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: SizedBox(
                width: iconSize,
                height: iconSize,
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.white, // Change this color as needed
                    BlendMode.srcIn,
                  ),
                  child: Image.asset('assets/images/ic_home.png'),
                ),
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: SizedBox(
                width: iconSize,
                height: iconSize,
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.white, // Change this color as needed
                    BlendMode.srcIn,
                  ),
                  child: Image.asset('assets/images/ic_music_album.png'),
                ),
              ),
              label: 'Library'),
        ],
      ),
    );
  }
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}
