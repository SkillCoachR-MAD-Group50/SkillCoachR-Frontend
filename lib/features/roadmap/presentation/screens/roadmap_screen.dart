import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../core/models/milestone.dart';
import '../../../../core/services/app_prefs.dart';
import '../../../../core/services/auth_service.dart';

import 'milestone_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';

class RoadmapScreen extends ConsumerStatefulWidget {
  final String goal;
  final String skill;
  final List<Milestone> milestones;

  const RoadmapScreen({
    super.key,
    required this.goal,
    required this.skill,
    required this.milestones,
  });

  @override
  ConsumerState<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends ConsumerState<RoadmapScreen> {
  String _filter = 'All';

  double _calcProgress() {
    if (widget.milestones.isEmpty) return 0;
    return widget.milestones.where((m) => m.completed).length / widget.milestones.length;
  }

  void _onScoreUpdated() {
    setState(() {
      AppPrefs.save(widget.goal, widget.skill, widget.milestones);
    });
  }

  // --- Mocked Data Generators ---
  String _getPriority(int index) {
    if (index < 2) return "High Priority";
    if (index < 4) return "Medium Priority";
    return "Low Priority";
  }

  String _getLevel(int index) {
    if (index == 0) return "Beginner";
    if (index < 3) return "Intermediate";
    return "Advanced";
  }

  Color _getPriorityColor(String priority) {
    if (priority.contains("High")) return const Color(0xFFEF4444);
    if (priority.contains("Medium")) return const Color(0xFFF59E0B);
    return const Color(0xFF3B82F6);
  }

  Color _getPriorityBg(String priority) {
    if (priority.contains("High")) return const Color(0xFFFEF2F2);
    if (priority.contains("Medium")) return const Color(0xFFFFFBEB);
    return const Color(0xFFEFF6FF);
  }

  String _getWeeks(int index) {
    return "${(index * 2) + 2}-${(index * 2) + 4} weeks";
  }

  int _countPriority(String startingWord) {
    return widget.milestones.where((m) {
      final p = _getPriority(widget.milestones.indexOf(m));
      return p.startsWith(startingWord);
    }).length;
  }

  List<Milestone> get _filteredMilestones {
    if (_filter == 'All') return widget.milestones;
    return widget.milestones.where((m) {
      final p = _getPriority(widget.milestones.indexOf(m));
      return p.startsWith(_filter);
    }).toList();
  }

  Milestone? get _nextUnlocked {
    for (int i = 0; i < widget.milestones.length; i++) {
      if (!widget.milestones[i].completed) {
        if (i == 0 || widget.milestones[i - 1].completed) return widget.milestones[i];
      }
    }
    return null;
  }

  void _startJourney() async {
    final nextM = _nextUnlocked;
    if (nextM != null) {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => MilestoneScreen(
                  milestone: nextM,
                  skill: widget.skill,
                  onScoreUpdated: _onScoreUpdated)));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.milestones.length;
    final completed = widget.milestones.where((m) => m.completed).length;
    final progress = (_calcProgress() * 100).round();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // TOP HEADER
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              color: const Color(0xFFF8FAFC),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(PhosphorIcons.caretLeft(), color: const Color(0xFF1E293B)),
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        // Fallback logout if root
                         ref.read(authServiceProvider).logout().then((_) {
                           if (context.mounted) context.go('/login');
                         });
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Your Learning Roadmap',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(PhosphorIcons.userCircle(), color: const Color(0xFF1E293B)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProfileScreen(
                            goal: widget.goal,
                            skill: widget.skill,
                            milestones: widget.milestones,
                            streak: 0, // Mocked for now, will implement proper streak service call if needed
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                  children: [
                    // Subtitle
                    Text(
                      'AI-generated path tailored to your goals',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // STATS ROW
                    Row(
                      children: [
                        _buildStatBox('$total', 'Total Skills', const Color(0xFF3B82F6)),
                        const SizedBox(width: 12),
                        _buildStatBox('$completed', 'Completed', const Color(0xFF10B981)),
                        const SizedBox(width: 12),
                        _buildStatBox('$progress%', 'Progress', const Color(0xFF06B6D4)),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // AI RECOMMENDATION BANNER
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF), // Soft light blue
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFDBEAFE)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(PhosphorIcons.sparkle(PhosphorIconsStyle.fill), color: const Color(0xFF0EA5E9), size: 24),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'AI Recommendation',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Start with high priority skills for maximum impact. Your roadmap adapts as you progress!",
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: const Color(0xFF475569),
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // FILTER BAR
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildFilterChip('All', null),
                            _buildFilterChip('High', _countPriority('High')),
                            _buildFilterChip('Medium', _countPriority('Medium')),
                            _buildFilterChip('Low', _countPriority('Low')),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // MILESTONE LIST
                    ..._filteredMilestones.map((m) {
                      final i = widget.milestones.indexOf(m);
                      final unlocked = true; // Allow free exploration (previously: i == 0 || widget.milestones[i - 1].completed);
                      final priorityText = _getPriority(i);
                      final levelText = _getLevel(i);
                      final weeksText = _getWeeks(i);

                      return IgnorePointer(
                        ignoring: false, // Do not ignore pointer
                        child: GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => MilestoneScreen(
                                        milestone: m,
                                        skill: widget.skill,
                                        onScoreUpdated: _onScoreUpdated)));
                            setState(() {});
                          },
                          child: Opacity(
                            opacity: unlocked ? 1.0 : 0.5,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: const Color(0xFFE2E8F0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.02),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Leading Radio Button Icon
                                  Container(
                                    margin: const EdgeInsets.only(top: 0),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      icon: Icon(
                                        m.completed ? PhosphorIcons.checkCircle(PhosphorIconsStyle.fill) : PhosphorIcons.circle(),
                                        color: m.completed ? const Color(0xFF10B981) : const Color(0xFF94A3B8),
                                        size: 24,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          m.completed = !m.completed;
                                          // Keep score to null or max depending on how we treat skips, let's keep it intact.
                                        });
                                        _onScoreUpdated();
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  // Content
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          m.title,
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF1E293B),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            // Level Badge
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFECFDF5),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                levelText,
                                                style: GoogleFonts.inter(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color(0xFF059669),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            // Priority Badge
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: _getPriorityBg(priorityText),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                priorityText,
                                                style: GoogleFonts.inter(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: _getPriorityColor(priorityText),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        // Time Estimate
                                        Row(
                                          children: [
                                            Icon(PhosphorIcons.clock(), size: 14, color: const Color(0xFF64748B)),
                                            const SizedBox(width: 4),
                                            Text(
                                              weeksText,
                                              style: GoogleFonts.inter(
                                                fontSize: 12,
                                                color: const Color(0xFF64748B),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: _nextUnlocked != null ? _startJourney : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB), // Darker blue matching mockup
              foregroundColor: Colors.white,
              disabledBackgroundColor: const Color(0xFF94A3B8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              _nextUnlocked != null ? 'Start Learning Journey' : 'Journey Completed!',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatBox(String value, String label, Color valueColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: valueColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, int? count) {
    final isSelected = _filter == label;
    return GestureDetector(
      onTap: () => setState(() => _filter = label),
      child: Container(
        margin: const EdgeInsets.only(right: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4, offset: const Offset(0, 2))]
              : null,
        ),
        child: Row(
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? const Color(0xFF0F172A) : const Color(0xFF475569),
              ),
            ),
            if (count != null) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFFEE2E2) : const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$count',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? const Color(0xFFDC2626) : const Color(0xFF64748B),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
