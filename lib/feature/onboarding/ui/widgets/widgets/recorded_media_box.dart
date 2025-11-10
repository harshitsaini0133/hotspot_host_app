import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intern_assignment/core/api_constants.dart';
import 'package:intern_assignment/core/app_color_pallete.dart';
import 'package:intern_assignment/core/app_dimensions.dart';
import 'package:intern_assignment/feature/onboarding/ui/widgets/widgets/video_player_screen.dart';
import 'package:intern_assignment/feature/onboarding/ui/widgets/timer_display.dart';
import 'package:intern_assignment/feature/onboarding/ui/widgets/wave_form_bar.dart';

class RecordedMediaBox extends StatefulWidget {
  final bool isRecording;
  final bool isPlaying;
  final int seconds;
  final MediaType? recordingType;
  final String? videoThumbnailPath;
  final VoidCallback onStop;
  final VoidCallback onPlayPause;
  final VoidCallback onDelete;
  final String videoPath;

  const RecordedMediaBox({
    super.key,
    required this.isRecording,
    required this.isPlaying,
    required this.seconds,
    required this.recordingType,
    required this.onStop,
    required this.onPlayPause,
    required this.onDelete,
    this.videoThumbnailPath,
    required this.videoPath,
  });

  @override
  State<RecordedMediaBox> createState() => _RecordedMediaBoxState();
}

class _RecordedMediaBoxState extends State<RecordedMediaBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<int> _durationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _durationAnimation =
        IntTween(begin: 0, end: widget.seconds).animate(_animationController);

    // If the widget is built in the "recorded" state, start the animation.
    if (!widget.isRecording) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(covariant RecordedMediaBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    // When transitioning from recording to recorded, restart the animation.
    if (oldWidget.isRecording && !widget.isRecording) {
      _durationAnimation =
          IntTween(begin: 0, end: widget.seconds).animate(_animationController);
      _animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool get isAudio => widget.recordingType == MediaType.audio;
  bool get isVideo => widget.recordingType == MediaType.video;
  bool get isMediaRecorded => !widget.isRecording;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            gradient: AppColorPallete.cardBG,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: AppColorPallete.text5, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              AppDimensions.spacingMedium,
              if (isAudio) ...[_buildControls()],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final statusText = widget.isRecording
        ? 'Recording ${isAudio ? 'Audio' : 'Video'}...'
        : 'Recorded ${isAudio ? 'Audio' : 'Video'}•';

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (isVideo && isMediaRecorded) ...[
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => VideoPlayerScreen(
                    videoPath: widget.videoPath,
                  ),
                ),
              );
            },
            child: AnimatedContainer(
                margin: const EdgeInsets.only(right: 8),
                height: 60,
                width: 60,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: isVideo && widget.videoThumbnailPath != null
                      ? DecorationImage(
                          image: FileImage(File(widget.videoThumbnailPath!)),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: widget.videoThumbnailPath != null
                    ? const Center(
                        child: Icon(Icons.play_arrow_outlined,
                            color: Colors.white))
                    : null),
          ),
        ],
        Text(
          statusText,
          style: const TextStyle(
            color: AppColorPallete.text1,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        if (isMediaRecorded) ...[
          const SizedBox(width: 2),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return TimerDisplay(
                seconds: _durationAnimation.value,
                fontcolor: AppColorPallete.text4,
              );
            },
          ),
          IconButton(
            onPressed: widget.onDelete,
            icon: const Icon(
              CupertinoIcons.trash,
              color: AppColorPallete.primaryColor,
              size: 20,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildControls() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton.filled(
          onPressed: widget.isRecording ? widget.onStop : widget.onPlayPause,
          icon: Icon(
            widget.isRecording
                ? (widget.seconds >= 10 ? Icons.check : Icons.mic_none_outlined)
                : (isAudio && widget.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow),
          ),
        ),
        Expanded(
          child: WaveformBar(
            barCount: isMediaRecorded ? 45 : 30,
            isPlaying: widget.isPlaying,
            isRecording: widget.isRecording,
          ),
        ),
        if (widget.isRecording) ...[
          const SizedBox(width: 8),
          TimerDisplay(seconds: widget.seconds),
        ],
      ],
    );
  }
}
