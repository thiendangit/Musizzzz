// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getSongsHash() => r'bd1cde81393ed5b51ee399722dc8f832a8af498e';

/// See also [getSongs].
@ProviderFor(getSongs)
final getSongsProvider = AutoDisposeFutureProvider<List<Song>>.internal(
  getSongs,
  name: r'getSongsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getSongsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetSongsRef = AutoDisposeFutureProviderRef<List<Song>>;
String _$getFavoriteSongsHash() => r'bfc14dc2d551c41d5661651f4abb14428a69dd4d';

/// See also [getFavoriteSongs].
@ProviderFor(getFavoriteSongs)
final getFavoriteSongsProvider =
    AutoDisposeFutureProvider<List<FavoriteSong>>.internal(
  getFavoriteSongs,
  name: r'getFavoriteSongsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getFavoriteSongsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetFavoriteSongsRef = AutoDisposeFutureProviderRef<List<FavoriteSong>>;
String _$homeViewModelHash() => r'7569375ad9234c2205b343135769f6986755aee1';

/// See also [HomeViewModel].
@ProviderFor(HomeViewModel)
final homeViewModelProvider =
    AutoDisposeNotifierProvider<HomeViewModel, AsyncValue?>.internal(
  HomeViewModel.new,
  name: r'homeViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomeViewModel = AutoDisposeNotifier<AsyncValue?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
