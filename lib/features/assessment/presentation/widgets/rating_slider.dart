import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';

class RatingSlider extends StatelessWidget {
  final int currentRating;
  final ValueChanged<int> onChanged;

  const RatingSlider({
    super.key,
    required this.currentRating,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Novice', style: GoogleFonts.inter(fontSize: 10, color: Colors.grey)),
            Text('Expert', style: GoogleFonts.inter(fontSize: 10, color: Colors.grey)),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: AppTheme.lightTheme.colorScheme.primary,
            inactiveTrackColor: Colors.grey.shade200,
            thumbColor: Colors.white,
            overlayColor: AppTheme.lightTheme.colorScheme.primary.withAlpha(51),
            valueIndicatorColor: AppTheme.lightTheme.colorScheme.primary,
            valueIndicatorTextStyle: const TextStyle(color: Colors.white),
          ),
          child: Slider(
            value: currentRating.toDouble(),
            min: 1,
            max: 5,
            divisions: 4,
            label: currentRating.toString(),
            onChanged: (value) => onChanged(value.toInt()),
          ),
        ),
      ],
    );
  }
}
