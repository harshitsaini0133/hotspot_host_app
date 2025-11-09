// lib/widgets/recording_toggle_button.dart
import 'package:flutter/material.dart';
import 'package:intern_assignment/core/app_color_pallete.dart';

class RecordingToggleButton extends StatefulWidget {
  final VoidCallback onVoiceRec;
  final VoidCallback onVideoRec;

  const RecordingToggleButton({
    super.key,
    required this.onVoiceRec,
    required this.onVideoRec,
  });

  @override
  State<RecordingToggleButton> createState() => _RecordingToggleButtonState();
}

class _RecordingToggleButtonState extends State<RecordingToggleButton> {
  int? selectedIndex;

  void _handleTap(int index) {
    setState(() => selectedIndex = index);
    if (index == 0) {
      widget.onVoiceRec();
    } else {
      widget.onVideoRec();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColorPallete.text5, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildToggleButton(
            index: 0,
            icon: Icons.mic_none_outlined,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
            gradientAlignment: Alignment.topLeft,
          ),
          Container(
            width: 1,
            margin: const EdgeInsets.symmetric(vertical: 20),
            color: AppColorPallete.text5,
          ),
          _buildToggleButton(
            index: 1,
            icon: Icons.videocam_outlined,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            gradientAlignment: Alignment.topRight,
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required int index,
    required IconData icon,
    required BorderRadius borderRadius,
    required Alignment gradientAlignment,
  }) {
    final isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => _handleTap(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            gradient: isSelected
                ? AppColorPallete.recordingButtonGradient(gradientAlignment)
                : null,
            color: isSelected ? null : Colors.black,
          ),
          child: Center(child: Icon(icon, color: Colors.white)),
        ),
      ),
    );
  }
}
