// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AssessmentNotifier)
final assessmentProvider = AssessmentNotifierProvider._();

final class AssessmentNotifierProvider
    extends $AsyncNotifierProvider<AssessmentNotifier, List<SkillModel>> {
  AssessmentNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assessmentProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assessmentNotifierHash();

  @$internal
  @override
  AssessmentNotifier create() => AssessmentNotifier();
}

String _$assessmentNotifierHash() =>
    r'f7cc753d80de9c1d23b37d449c1bba11df3ecdf3';

abstract class _$AssessmentNotifier extends $AsyncNotifier<List<SkillModel>> {
  FutureOr<List<SkillModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<SkillModel>>, List<SkillModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<SkillModel>>, List<SkillModel>>,
              AsyncValue<List<SkillModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
