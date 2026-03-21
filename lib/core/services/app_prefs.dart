import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/milestone.dart';

class AppPrefs {
  static const _key = 'skillcoachr_data';

  static Future<void> save(
      String goal, String skill, List<Milestone> milestones) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode({
      'goal': goal, 'skill': skill,
      'milestones': milestones.map((m) => m.toJson()).toList(),
    }));
  }

  static Future<Map<String, dynamic>?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_key);
    if (saved == null) return null;
    try { return jsonDecode(saved) as Map<String, dynamic>; }
    catch (_) { return null; }
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
