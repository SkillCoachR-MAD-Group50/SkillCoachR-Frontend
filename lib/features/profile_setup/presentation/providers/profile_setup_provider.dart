import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_setup_provider.g.dart';

@Riverpod(keepAlive: true)
class ProfileSetup extends _$ProfileSetup {
  @override
  String? build() {
    return null; // Initial state is no career goal selected
  }


  void setCareerGoal(String? goal) {
    state = goal;
  }
}
