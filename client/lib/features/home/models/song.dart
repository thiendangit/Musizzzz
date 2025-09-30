import 'dart:io';

class SongCreate {
  String title;
  String artist;
  File song;
  File thumbnail;
  String color;

  SongCreate(
      {required this.title,
      required this.artist,
      required this.song,
      required this.thumbnail,
      required this.color});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'artist': artist,
      'song': song,
      'thumbnail': thumbnail,
      'color': color,
    };
  }

  factory SongCreate.fromMap(Map<String, dynamic> map) {
    return SongCreate(
      title: map['title'],
      artist: map['artist'],
      song: map['song'],
      thumbnail: map['thumbnail'],
      color: map['color'],
    );
  }
}

class Song {
  String id;
  String name;
  String artist;
  String songFile;
  String thumbnail;
  String hexCode;
  String userId;

  Song({
    required this.id,
    required this.name,
    required this.artist,
    required this.songFile,
    required this.thumbnail,
    required this.hexCode,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'artist': artist,
      'song_file': songFile,
      'thumbnail': thumbnail,
      'hex_code': hexCode,
      'user_id': userId,
    };
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      artist: map['artist']?.toString() ?? '',
      songFile: map['song_file']?.toString() ?? '',
      thumbnail: map['thumbnail']?.toString() ?? '',
      hexCode: map['hex_code']?.toString() ?? '',
      userId: map['user_id']?.toString() ?? '',
    );
  }
}

class FavoriteSong {
  String id;
  String userId;
  String songId;
  Song song;

  FavoriteSong({
    required this.id,
    required this.userId,
    required this.songId,
    required this.song,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'song_id': songId,
      'song': song.toMap(),
    };
  }

  factory FavoriteSong.fromMap(Map<String, dynamic> map) {
    return FavoriteSong(
      id: map['id']?.toString() ?? '',
      userId: map['user_id']?.toString() ?? '',
      songId: map['song_id']?.toString() ?? '',
      song: Song.fromMap(map['song'] ?? {}),
    );
  }
}
