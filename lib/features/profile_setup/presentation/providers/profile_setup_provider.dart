import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_setup_provider.g.dart';

@Riverpod(keepAlive: true)
class ProfileSetupNotifier extends _$ProfileSetupNotifier {
  @override
  String? build() {
    return null; // Initial state is no career goal selected
  }

  void setCareerGoal(String? goal) {
    state = goal;
  }
}
