import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../core/models/milestone.dart';
import '../../../../core/services/app_prefs.dart';
import '../../../../core/services/streak_service.dart';

import 'milestone_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';

class RoadmapScreen extends StatefulWidget {
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
  State<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> with TickerProviderStateMixin {
  int _navIndex = 0;
  int _streak = 0;
  late AnimationController _progressCtrl;
  late Animation<double> _progressAnim;

  @override
  void initState() {
    super.initState();
    _progressCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _progressAnim = Tween<double>(begin: 0, end: _calcProgress()).animate(
        CurvedAnimation(parent: _progressCtrl, curve: Curves.easeOutCubic));
    _progressCtrl.forward();
    _loadStreak();
  }

  @override
  void dispose() {
    _progressCtrl.dispose();
    super.dispose();
  }

  double _calcProgress() {
    if (widget.milestones.isEmpty) return 0;
    return widget.milestones.where((m) => m.completed).length /
        widget.milestones.length;
  }


  Future<void> _loadStreak() async {
    final s = await StreakService.loadAndUpdate();
    if (mounted) setState(() => _streak = s);
  }

  void _onScoreUpdated() {
    final oldProg = _progressAnim.value;
    final newProg = _calcProgress();
    
    setState(() {
      AppPrefs.save(widget.goal, widget.skill, widget.milestones);
      _progressCtrl.reset();
      _progressAnim = Tween<double>(begin: oldProg, end: newProg).animate(
          CurvedAnimation(parent: _progressCtrl, curve: Curves.easeOutCubic));
      _progressCtrl.forward();
    });
  }

  Widget _buildRoadmap() {
    final completed = widget.milestones.where((m) => m.completed).length;
    final total = widget.milestones.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // AppBar Style Header
        Container(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Learning Roadmap',
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  Text(
                    'Mastering ${widget.skill}',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
              if (_streak > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF7ED),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFFFEDD5)),
                  ),
                  child: Row(
                    children: [
                      Icon(PhosphorIcons.fire(PhosphorIconsStyle.fill), color: Colors.orange, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        '$_streak',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),

        // Progress Overview Card
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Overall Progress',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${(_calcProgress() * 100).round()}%',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                AnimatedBuilder(
                  animation: _progressAnim,
                  builder: (_, __) => Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: _progressAnim.value,
                          minHeight: 8,
                          backgroundColor: Colors.white.withOpacity(0.2),
                          valueColor: const AlwaysStoppedAnimation(Colors.white),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$completed of $total milestones completed',
                        style: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 32),

        // Milestone List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            itemCount: widget.milestones.length,
            itemBuilder: (_, i) {
              final m = widget.milestones[i];
              final unlocked = i == 0 || widget.milestones[i - 1].completed;
              final bool isCurrent = unlocked && !m.completed;
              
              return GestureDetector(
                onTap: unlocked
                    ? () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MilestoneScreen(
                                    milestone: m,
                                    skill: widget.skill,
                                    onScoreUpdated: _onScoreUpdated)));
                        setState(() {});
                      }
                    : null,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Status Line and Dot
                      Column(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: m.completed
                                  ? const Color(0xFF10B981)
                                  : unlocked
                                      ? const Color(0xFF3B82F6)
                                      : const Color(0xFFE2E8F0),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isCurrent ? const Color(0xFFBFDBFE) : Colors.transparent,
                                width: 4,
                              ),
                            ),
                            child: Icon(
                              m.completed
                                  ? PhosphorIcons.check(PhosphorIconsStyle.bold)
                                  : unlocked
                                      ? PhosphorIcons.bookOpen(PhosphorIconsStyle.fill)
                                      : PhosphorIcons.lock(PhosphorIconsStyle.fill),
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          if (i < widget.milestones.length - 1)
                            Container(
                              width: 2,
                              height: 60,
                              color: m.completed ? const Color(0xFF10B981) : const Color(0xFFE2E8F0),
                            ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      // Content Card
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isCurrent ? const Color(0xFF3B82F6) : const Color(0xFFE2E8F0),
                              width: isCurrent ? 1.5 : 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Phase ${i + 1}: ${m.title}',
                                      style: GoogleFonts.outfit(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: unlocked ? const Color(0xFF1E293B) : const Color(0xFF94A3B8),
                                      ),
                                    ),
                                  ),
                                  if (m.completed)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFECFDF5),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        '${m.score}%',
                                        style: GoogleFonts.inter(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF059669),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                m.description,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: unlocked ? const Color(0xFF64748B) : const Color(0xFFCBD5E1),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: IndexedStack(
          index: _navIndex,
          children: [
            _buildRoadmap(),
            ProfileScreen(
              goal: widget.goal,
              skill: widget.skill,
              milestones: widget.milestones,
              streak: _streak,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: const Border(top: BorderSide(color: Color(0xFFF1F5F9), width: 1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            )
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _navIndex,
          onTap: (i) => setState(() => _navIndex = i),
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF3B82F6),
          unselectedItemColor: const Color(0xFF94A3B8),
          selectedLabelStyle: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.bold),
          unselectedLabelStyle: GoogleFonts.outfit(fontSize: 12),
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.mapTrifold()),
              activeIcon: Icon(PhosphorIcons.mapTrifold(PhosphorIconsStyle.fill)),
              label: 'Roadmap',
            ),
            BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.user()),
              activeIcon: Icon(PhosphorIcons.user(PhosphorIconsStyle.fill)),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

