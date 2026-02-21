// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(skillRepository)
final skillRepositoryProvider = SkillRepositoryProvider._();

final class SkillRepositoryProvider
    extends
        $FunctionalProvider<SkillRepository, SkillRepository, SkillRepository>
    with $Provider<SkillRepository> {
  SkillRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'skillRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$skillRepositoryHash();

  @$internal
  @override
  $ProviderElement<SkillRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SkillRepository create(Ref ref) {
    return skillRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SkillRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SkillRepository>(value),
    );
  }
}

String _$skillRepositoryHash() => r'cb9552b3d15c90e3a8f5f3faa09a655cf7eb2a6d';
