import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingSlider extends StatelessWidget {
  final String skillName;
  final double rating;
  final ValueChanged<double> onChanged;

  const RatingSlider({
    super.key,
    required this.skillName,
    required this.rating,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skillName,
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2C3E50),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF0052D4).withAlpha(26), // 0.1 opacity
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${rating.toInt()}/5',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0052D4),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFF4364F7),
              inactiveTrackColor: Colors.grey.shade200,
              thumbColor: const Color(0xFF0052D4),
              overlayColor: const Color(0xFF0052D4).withAlpha(32),
              trackHeight: 8.0,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 24.0),
              tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 4.0),
              activeTickMarkColor: Colors.white.withAlpha(128), // 0.5 opacity
              inactiveTickMarkColor: const Color(0xFF0052D4).withAlpha(51), // 0.2
            ),
            child: Slider(
              value: rating,
              min: 1,
              max: 5,
              divisions: 4,
              onChanged: onChanged,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Novice', style: GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
              Text('Expert', style: GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
