// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Assessment)
final assessmentProvider = AssessmentProvider._();

final class AssessmentProvider
    extends $NotifierProvider<Assessment, Map<String, double>> {
  AssessmentProvider._()
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
  String debugGetCreateSourceHash() => _$assessmentHash();

  @$internal
  @override
  Assessment create() => Assessment();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, double> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, double>>(value),
    );
  }
}

String _$assessmentHash() => r'77eda04e25ceea26847d3273a565707a710bd95f';

abstract class _$Assessment extends $Notifier<Map<String, double>> {
  Map<String, double> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Map<String, double>, Map<String, double>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, double>, Map<String, double>>,
              Map<String, double>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
