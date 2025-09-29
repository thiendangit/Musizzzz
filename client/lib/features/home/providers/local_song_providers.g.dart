// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_song_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getLocalSongsHash() => r'01c66a065966bcfa263486cae04f6963c7ffe45d';

/// See also [getLocalSongs].
@ProviderFor(getLocalSongs)
final getLocalSongsProvider = AutoDisposeFutureProvider<List<Song>>.internal(
  getLocalSongs,
  name: r'getLocalSongsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getLocalSongsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetLocalSongsRef = AutoDisposeFutureProviderRef<List<Song>>;
String _$localSongNotifierHash() => r'756c8cea328186ce4454ca7ca5b498d8c7e69e65';

/// See also [LocalSongNotifier].
@ProviderFor(LocalSongNotifier)
final localSongNotifierProvider =
    AutoDisposeAsyncNotifierProvider<LocalSongNotifier, List<Song>>.internal(
  LocalSongNotifier.new,
  name: r'localSongNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$localSongNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LocalSongNotifier = AutoDisposeAsyncNotifier<List<Song>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
