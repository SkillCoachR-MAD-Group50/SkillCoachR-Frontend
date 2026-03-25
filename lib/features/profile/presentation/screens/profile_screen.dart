import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/models/milestone.dart';
import '../../../../core/services/app_prefs.dart';
import '../../../../core/services/streak_service.dart';


class ProfileScreen extends StatelessWidget {
  final String goal;
  final String skill;
  final List<Milestone> milestones;
  final int streak;

  const ProfileScreen({
    super.key,
    required this.goal,
    required this.skill,
    required this.milestones,
    required this.streak,
  });

  int get _completed => milestones.where((m) => m.completed).length;
  int get _total => milestones.length;

  double get _avgScore {
    final scored = milestones.where((m) => m.score > -1).toList();
    if (scored.isEmpty) return 0;
    return scored.map((m) => m.score).reduce((a, b) => a + b) / scored.length;
  }

  @override
  Widget build(BuildContext context) {
    final avg = _avgScore;
    final progress = _total == 0 ? 0.0 : _completed / _total;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ─────────────────────────────────────────────────
          const Text('Your Profile',
              style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('Track your learning journey',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
          const SizedBox(height: 24),

          // ── Goal & Skill Card ───────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.accent, AppTheme.accentLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
            ),

            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle),
                  child: const Icon(Icons.psychology_rounded,
                      color: Colors.white, size: 28),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(skill,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 3),
                      Text('Goal: $goal',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.75),
                              fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ── Stats Grid ─────────────────────────────────────────────
          Row(
            children: [
              Expanded(
                  child: _statCard(Icons.flag_rounded, AppTheme.success,
                      '$_completed / $_total', 'Milestones Done')),
              const SizedBox(width: 12),
              Expanded(
                  child: _statCard(Icons.local_fire_department_rounded,
                      const Color(0xFFFF6422), '$streak', 'Day Streak')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                  child: _statCard(
                      Icons.star_rounded,
                      AppTheme.warning,
                      avg > 0 ? '${avg.toStringAsFixed(0)}%' : '—',
                      'Avg Quiz Score')),
              const SizedBox(width: 12),
              Expanded(
                  child: _statCard(
                      Icons.percent_rounded,
                      AppTheme.accentLight,
                      '${(progress * 100).toStringAsFixed(0)}%',
                      'Overall Progress')),
            ],
          ),
          const SizedBox(height: 24),

          // ── Progress Bar ───────────────────────────────────────────
          const Text('Learning Progress',
              style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 15)),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor: AppTheme.border,
              valueColor: const AlwaysStoppedAnimation(AppTheme.accent),
            ),
          ),
          const SizedBox(height: 8),
          Text('$_completed of $_total milestones completed',
              style:
                  const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
          const SizedBox(height: 32),

          // ── Milestone Score Breakdown ───────────────────────────────
          if (milestones.any((m) => m.score > -1)) ...[
            const Text('Quiz Scores',
                style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 15)),
            const SizedBox(height: 12),
            ...milestones.where((m) => m.score > -1).map((m) {
              final color = m.score >= 70 ? AppTheme.success : AppTheme.danger;
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  gradient: AppTheme.cardGradient,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Row(children: [
                  Icon(
                    m.completed
                        ? Icons.check_circle_rounded
                        : Icons.cancel_rounded,
                    color: color,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text('Phase ${m.index + 1}  •  ${m.title}',
                        style: const TextStyle(
                            color: AppTheme.textPrimary,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(width: 8),
                  Text('${m.score}%',
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                ]),
              );
            }),
            const SizedBox(height: 20),
          ],

          // ── Reset Button ───────────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: AppTheme.cardGradient,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Start Fresh',
                    style: TextStyle(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                const SizedBox(height: 4),
                const Text('Clear your roadmap and start a new skill path.',
                    style:
                        TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (_) => AlertDialog(
                          backgroundColor: AppTheme.card,
                          title: const Text('Reset Progress?',
                              style: TextStyle(color: AppTheme.textPrimary)),
                          content: const Text(
                              'This will clear all your progress and start over.',
                              style: TextStyle(color: AppTheme.textSecondary)),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancel')),
                            TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Reset',
                                    style: TextStyle(color: AppTheme.danger))),
                          ],
                        ),
                      );
                      if (confirmed == true && context.mounted) {
                        await AppPrefs.clear();
                        await StreakService.clear();
                        // Note: In integrated app, we might need a different way to go back to start
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.danger,
                      side: const BorderSide(color: AppTheme.danger, width: 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    icon: const Icon(Icons.refresh_rounded, size: 16),
                    label: const Text('Reset & Start Over',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(IconData icon, Color color, String value, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppTheme.cardGradient,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 10),
          Text(value,
              style: TextStyle(
                  color: color, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(label,
              style:
                  const TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
        ],
      ),
    );
  }
}
