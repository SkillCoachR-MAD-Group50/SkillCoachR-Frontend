import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assessment_provider.g.dart';

@riverpod
class Assessment extends _$Assessment {
  @override
  Map<String, double> build() {
    // Initial state: empty map of skill ratings
    return {};
  }

  void updateSkillRating(String skillName, double rating) {
    // Create a new map with the updated rating to trigger a state rebuild
    state = {
      ...state,
      skillName: rating,
    };
  }
  
  void clearRatings() {
    state = {};
  }
}
