// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_movies_details_command.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(GetMoviesDetailsCommand)
const getMoviesDetailsCommandProvider = GetMoviesDetailsCommandProvider._();

final class GetMoviesDetailsCommandProvider
    extends
        $NotifierProvider<GetMoviesDetailsCommand, AsyncValue<MovieDetail?>> {
  const GetMoviesDetailsCommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getMoviesDetailsCommandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getMoviesDetailsCommandHash();

  @$internal
  @override
  GetMoviesDetailsCommand create() => GetMoviesDetailsCommand();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<MovieDetail?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<MovieDetail?>>(value),
    );
  }
}

String _$getMoviesDetailsCommandHash() =>
    r'4ba0457a0921d741c17d156b8512c580ba17d041';

abstract class _$GetMoviesDetailsCommand
    extends $Notifier<AsyncValue<MovieDetail?>> {
  AsyncValue<MovieDetail?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<MovieDetail?>, AsyncValue<MovieDetail?>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<MovieDetail?>, AsyncValue<MovieDetail?>>,
              AsyncValue<MovieDetail?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
