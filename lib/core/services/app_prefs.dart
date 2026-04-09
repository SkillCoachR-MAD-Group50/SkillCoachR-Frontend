import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/milestone.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AppPrefs {
  static const _key = 'skillcoachr_data';

  static Future<void> save(
      String goal, String skill, List<Milestone> milestones) async {
    final prefs = await SharedPreferences.getInstance();
    final data = {
      'goal': goal, 'skill': skill,
      'milestones': milestones.map((m) => m.toJson()).toList(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
    await prefs.setString(_key, jsonEncode({
      'goal': goal, 'skill': skill,
      'milestones': milestones.map((m) => m.toJson()).toList(),
    }));

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('progress')
            .doc('current_learning_path')
            .set(data, SetOptions(merge: true));
      } catch (e) {
        debugPrint('Failed to sync progress to Firestore: $e');
      }
    }
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
