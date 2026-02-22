// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_setup_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProfileSetupNotifier)
final profileSetupProvider = ProfileSetupNotifierProvider._();

final class ProfileSetupNotifierProvider
    extends $NotifierProvider<ProfileSetupNotifier, String?> {
  ProfileSetupNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileSetupProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileSetupNotifierHash();

  @$internal
  @override
  ProfileSetupNotifier create() => ProfileSetupNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$profileSetupNotifierHash() =>
    r'397c81c9c5c42748eb5582828a79bed53d6ed8b6';

abstract class _$ProfileSetupNotifier extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
