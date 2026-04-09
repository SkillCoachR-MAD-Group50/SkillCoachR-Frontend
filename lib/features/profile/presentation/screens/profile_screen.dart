import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/models/milestone.dart';
import '../../../../core/services/app_prefs.dart';
import '../../../../core/services/streak_service.dart';

class ProfileScreen extends ConsumerStatefulWidget {
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

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  Map<String, dynamic>? _weeklyRecommendation;
  bool _isLoadingRec = true;

  @override
  void initState() {
    super.initState();
    _fetchWeeklyRecommendation();
  }

  Future<void> _fetchWeeklyRecommendation() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final snap = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('weeklyRecommendations')
            .orderBy('generatedAt', descending: true)
            .limit(1)
            .get();

        if (snap.docs.isNotEmpty) {
          setState(() {
            _weeklyRecommendation = snap.docs.first.data();
          });
        }
      }
    } catch (e) {
      debugPrint("Error fetching weekly recommendation: $e");
    } finally {
      if (mounted) setState(() => _isLoadingRec = false);
    }
  }

  int get _completed => widget.milestones.where((m) => m.completed).length;
  int get _total => widget.milestones.length;

  double get _avgScore {
    final scored = widget.milestones.where((m) => m.score > -1).toList();
    if (scored.isEmpty) return 0;
    return scored.map((m) => m.score).reduce((a, b) => a + b) / scored.length;
  }

  @override
  Widget build(BuildContext context) {
    final avg = _avgScore;
    final progress = _total == 0 ? 0.0 : _completed / _total;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text('Analytics & Progress', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18, color: const Color(0xFF0F172A))),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF0F172A)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Goal & Skill Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3B82F6).withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                   Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(PhosphorIcons.target(), color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.skill, style: GoogleFonts.outfit(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('Goal: ${widget.goal}', style: GoogleFonts.inter(color: Colors.white.withOpacity(0.8), fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Intelligence / Recommendations Hook
            _buildSectionTitle('AI Coaching'),
            const SizedBox(height: 12),
            if (_isLoadingRec)
              const Center(child: CircularProgressIndicator())
            else if (_weeklyRecommendation != null)
              _buildRecommendationCard()
            else
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                     Icon(PhosphorIcons.clock(), color: const Color(0xFF94A3B8)),
                    const SizedBox(width: 12),
                    Expanded(child: Text("Your first weekly recommendation will be generated next Monday based on your progress.", style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF64748B)))),
                  ],
                ),
              ),
            const SizedBox(height: 28),

            // Stats Grids
            Row(
              children: [
                Expanded(child: _statCard(PhosphorIcons.flag(), const Color(0xFF10B981), '$_completed / $_total', 'Milestones')),
                const SizedBox(width: 12),
                Expanded(child: _statCard(PhosphorIcons.fire(), const Color(0xFFFF6422), '${widget.streak}', 'Day Streak')),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _statCard(PhosphorIcons.star(), const Color(0xFFF59E0B), avg > 0 ? '${avg.toStringAsFixed(0)}%' : '—', 'Avg Score')),
                const SizedBox(width: 12),
                Expanded(child: _statCard(PhosphorIcons.trendUp(), const Color(0xFF3B82F6), '${(progress * 100).toStringAsFixed(0)}%', 'Progress')),
              ],
            ),
            const SizedBox(height: 32),

            // Visual Skill Analytics - FL Chart
            if (widget.milestones.any((m) => m.score > -1)) ...[
              _buildSectionTitle('Score Trajectory'),
              const SizedBox(height: 12),
              Container(
                height: 220,
                padding: const EdgeInsets.only(top: 24, bottom: 12, left: 12, right: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: BarChart(
                  _mainBarData(),
                ),
              ),
              const SizedBox(height: 32),
              
              _buildSectionTitle('Milestone Breakdown'),
              const SizedBox(height: 12),
              ...widget.milestones.where((m) => m.score > -1).map((m) {
                final isPass = m.score >= 70;
                final color = isPass ? const Color(0xFF10B981) : const Color(0xFFEF4444);
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2)),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(isPass ? PhosphorIcons.checkCircle() : PhosphorIcons.warningCircle(), color: color, size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(m.title, style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 14, color: const Color(0xFF0F172A)), maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                      const SizedBox(width: 8),
                      Text('${m.score}%', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16, color: color)),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 24),
            ],

            // Reset Button
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFEE2E2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Start Fresh', style: GoogleFonts.inter(color: const Color(0xFFDC2626), fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 4),
                  Text('Clear your roadmap and start a new skill path.', style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 12)),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (_) => AlertDialog(
                            backgroundColor: Colors.white,
                            title: const Text('Reset Progress?'),
                            content: const Text('This will clear all your progress and start over.'),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                              TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Reset', style: TextStyle(color: Colors.red))),
                            ],
                          ),
                        );
                        if (confirmed == true && context.mounted) {
                          await AppPrefs.clear();
                          await StreakService.clear();
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFDC2626),
                        side: const BorderSide(color: Color(0xFFDC2626), width: 1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      icon: Icon(PhosphorIcons.arrowCounterClockwise(), size: 18),
                      label: Text('Reset & Start Over', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF0F172A),
      ),
    );
  }

  Widget _buildRecommendationCard() {
    final title = _weeklyRecommendation?['weeklyFocus'] ?? "Keep up the great work!";
    final picks = _weeklyRecommendation?['picks'] as List<dynamic>? ?? [];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF), // Soft AI blue matching mockup
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDBEAFE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(PhosphorIcons.sparkle(PhosphorIconsStyle.fill), color: const Color(0xFF0EA5E9), size: 20),
              const SizedBox(width: 8),
              Text('Weekly Recommendation', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13, color: const Color(0xFF0369A1))),
            ],
          ),
          const SizedBox(height: 12),
          Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15, color: const Color(0xFF0F172A))),
          if (picks.isNotEmpty) ...[
            const SizedBox(height: 12),
            ...picks.take(2).map((p) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4, right: 8),
                    child: Icon(PhosphorIcons.caretDoubleRight(PhosphorIconsStyle.fill), color: const Color(0xFF0EA5E9), size: 12),
                  ),
                  Expanded(
                    child: Text(
                      "${p['skill']}: ${p['resource']}",
                      style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF334155), height: 1.4),
                    ),
                  ),
                ],
              ),
            )),
          ]
        ],
      ),
    );
  }

  Widget _statCard(IconData icon, Color color, String value, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(value, style: GoogleFonts.inter(color: color, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 12)),
        ],
      ),
    );
  }

  BarChartData _mainBarData() {
    final scoredMilestones = widget.milestones.where((m) => m.score > -1).toList();
    
    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: 100,
      minY: 0,
      barTouchData: BarTouchData(enabled: true),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              final idx = value.toInt();
              if (idx < 0 || idx >= scoredMilestones.length) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('P${idx + 1}', style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 11)),
              );
            },
            reservedSize: 28,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 32,
            getTitlesWidget: (value, meta) {
              if (value % 25 != 0) return const SizedBox.shrink();
              return Text('${value.toInt()}', style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 10));
            },
          ),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 25,
        getDrawingHorizontalLine: (val) => FlLine(color: const Color(0xFFF1F5F9), strokeWidth: 1),
      ),
      borderData: FlBorderData(show: false),
      barGroups: scoredMilestones.asMap().entries.map((entry) {
        final i = entry.key;
        final score = entry.value.score.toDouble();
        final isPass = score >= 70;
        return BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: score,
              color: isPass ? const Color(0xFF3B82F6) : const Color(0xFFEF4444), // Primary Blue or Red
              width: 18,
              borderRadius: BorderRadius.circular(4),
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                toY: 100,
                color: const Color(0xFFF1F5F9), // Track color
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
