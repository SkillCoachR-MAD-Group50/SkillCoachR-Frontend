import 'package:shared_preferences/shared_preferences.dart';

class StreakService {
  static const _keyDate = 'streak_last_date';
  static const _keyStreak = 'streak_count';

  /// Load and update the streak. Returns the current streak count.
  static Future<int> loadAndUpdate() async {
    final prefs = await SharedPreferences.getInstance();
    final today = _dateKey(DateTime.now());
    final lastDate = prefs.getString(_keyDate) ?? '';
    int streak = prefs.getInt(_keyStreak) ?? 0;

    if (lastDate == today) {
      // Already counted today — no change
      return streak;
    }

    final yesterday =
        _dateKey(DateTime.now().subtract(const Duration(days: 1)));
    if (lastDate == yesterday) {
      // Consecutive day!
      streak++;
    } else {
      // Gap — reset to 1
      streak = 1;
    }

    await prefs.setString(_keyDate, today);
    await prefs.setInt(_keyStreak, streak);
    return streak;
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyDate);
    await prefs.remove(_keyStreak);
  }

  static String _dateKey(DateTime dt) =>
      '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
}
