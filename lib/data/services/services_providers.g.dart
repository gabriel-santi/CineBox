// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(googleSigninService)
const googleSigninServiceProvider = GoogleSigninServiceProvider._();

final class GoogleSigninServiceProvider
    extends
        $FunctionalProvider<
          GoogleSignInService,
          GoogleSignInService,
          GoogleSignInService
        >
    with $Provider<GoogleSignInService> {
  const GoogleSigninServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'googleSigninServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$googleSigninServiceHash();

  @$internal
  @override
  $ProviderElement<GoogleSignInService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GoogleSignInService create(Ref ref) {
    return googleSigninService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoogleSignInService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoogleSignInService>(value),
    );
  }
}

String _$googleSigninServiceHash() =>
    r'be1ff3215c98dc243bfef8c7d3be0c76add2e9c6';

@ProviderFor(localStorageService)
const localStorageServiceProvider = LocalStorageServiceProvider._();

final class LocalStorageServiceProvider
    extends
        $FunctionalProvider<
          LocalStorageService,
          LocalStorageService,
          LocalStorageService
        >
    with $Provider<LocalStorageService> {
  const LocalStorageServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localStorageServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localStorageServiceHash();

  @$internal
  @override
  $ProviderElement<LocalStorageService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalStorageService create(Ref ref) {
    return localStorageService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalStorageService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalStorageService>(value),
    );
  }
}

String _$localStorageServiceHash() =>
    r'6393dfa3b7044bce3761873180d69dc9438297b5';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
