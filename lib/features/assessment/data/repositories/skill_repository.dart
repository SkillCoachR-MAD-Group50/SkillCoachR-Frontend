import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/skill_model.dart';

part 'skill_repository.g.dart';

abstract class SkillRepository {
  Future<List<SkillModel>> getSkillsToAssess();
  Future<void> submitAssessment(List<SkillModel> assessedSkills);
}

class FakeSkillRepository implements SkillRepository {
  @override
  Future<List<SkillModel>> getSkillsToAssess() async {
    // Simulated network delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    return [
      const SkillModel(id: '1', name: 'Flutter UI', category: 'Frontend Development'),
      const SkillModel(id: '2', name: 'Riverpod State Management', category: 'Frontend Development'),
      const SkillModel(id: '3', name: 'Dart Programming', category: 'Core Language'),
      const SkillModel(id: '4', name: 'Firebase Auth', category: 'Backend Integration'),
      const SkillModel(id: '5', name: 'Cloud Firestore', category: 'Backend Integration'),
    ];
  }

  @override
  Future<void> submitAssessment(List<SkillModel> assessedSkills) async {
    // Simulated network delay
    await Future.delayed(const Duration(seconds: 1));
    // Here it would send the updated ratings to Firebase
    debugPrint('Submitted skills: ${assessedSkills.map((s) => '${s.name}: ${s.currentRating}')}');
  }
}

@riverpod
SkillRepository skillRepository(Ref ref) {
  // Return the fake implementation until Firebase is integrated
  return FakeSkillRepository();
}
