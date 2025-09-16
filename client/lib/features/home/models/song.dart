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
  String title;
  String artist;
  String song;
  String thumbnail;
  String color;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.song,
    required this.thumbnail,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'song': song,
      'thumbnail': thumbnail,
      'color': color,
    };
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      id: map['id'],
      title: map['title'],
      artist: map['artist'],
      song: map['song'],
      thumbnail: map['thumbnail'],
      color: map['color'],
    );
  }
}
