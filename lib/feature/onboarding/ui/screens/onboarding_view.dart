import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intern_assignment/core/api_constants.dart';
import 'package:intern_assignment/core/app_dimensions.dart';
import 'package:intern_assignment/core/app_textstyles.dart';
import 'package:intern_assignment/core/app_color_pallete.dart';
import 'package:intern_assignment/utils/assets.dart';
import 'package:intern_assignment/global_widgets/custom_app_bar.dart';
import 'package:intern_assignment/global_widgets/custom_button.dart';
import 'package:intern_assignment/global_widgets/custom_form_field.dart';
import 'package:intern_assignment/feature/onboarding/ui/bloc/onboarding_bloc.dart';
import 'package:intern_assignment/feature/onboarding/ui/widgets/recorded_media_box.dart';
import 'package:intern_assignment/feature/onboarding/ui/widgets/recording_button.dart';

class OnboardingView extends StatelessWidget {
  final TextEditingController textController;
  final ScrollController scrollController;
  final FocusNode focusNode;

  const OnboardingView({
    super.key,
    required this.textController,
    required this.scrollController,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(progress: 0.8),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  Assets.bgImage,
                  fit: BoxFit.fill,
                ),
              ),
              BlocListener<OnboardingBloc, OnboardingState>(
                  listener: (context, state) {
                    if (state.status == OnboardingStatus.failure &&
                        state.errorMessage != null) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(content: Text(state.errorMessage!)),
                        );
                    }
                  },
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: Padding(
                        padding: AppDimensions.paddingMedium,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text('02', style: AppTextStyles.stepperstyle),
                            const SizedBox(height: 8),
                            const Text(
                              'Why do you want to host with us?',
                              style: AppTextStyles.titleStyle,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Tell us about your intent and what motivates you to create experiences.',
                              style: TextStyle(
                                color: AppColorPallete.text3,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            AppDimensions.spacingMedium,
                            CustomFormField(
                              focusNode: focusNode,
                              maxLines: 6,
                              controller: textController,
                              hintText: '/ Start typing here',
                            ),
                            AppDimensions.spacingMedium,

                            // Recorded / Recording UI
                            BlocBuilder<OnboardingBloc, OnboardingState>(
                              builder: (context, state) {
                                final isRecording =
                                    state.status == OnboardingStatus.recording;
                                final isPlaying =
                                    state.status == OnboardingStatus.playing;
                                final isRecorded = state.status ==
                                        OnboardingStatus.recorded ||
                                    state.status == OnboardingStatus.playing ||
                                    state.status == OnboardingStatus.paused;

                                if (isRecording || isRecorded) {
                                  return RecordedMediaBox(
                                    videoPath: state.recordingPath!,
                                    isRecording: isRecording,
                                    isPlaying: isPlaying,
                                    seconds: state.seconds,
                                    recordingType: state.recordingType,
                                    videoThumbnailPath: state.thumbnailPath,
                                    onStop: () => context
                                        .read<OnboardingBloc>()
                                        .add(RecordingStopped()),
                                    onPlayPause: () {
                                      isPlaying
                                          ? context
                                              .read<OnboardingBloc>()
                                              .add(PlaybackPaused())
                                          : context
                                              .read<OnboardingBloc>()
                                              .add(PlaybackStarted());
                                    },
                                    onDelete: () => context
                                        .read<OnboardingBloc>()
                                        .add(RecordingDeleted()),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                            AppDimensions.spacingMedium,

                            // Recording + Next Button Row
                            BlocBuilder<OnboardingBloc, OnboardingState>(
                              builder: (context, state) {
                                final isRecording =
                                    state.status == OnboardingStatus.recording;
                                final isRecorded = state.status ==
                                        OnboardingStatus.recorded ||
                                    state.status == OnboardingStatus.playing ||
                                    state.status == OnboardingStatus.paused;

                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Visibility(
                                      visible: isRecording || !isRecorded,
                                      child: Expanded(
                                        child: RecordingToggleButton(
                                          onVoiceRec: () => context
                                              .read<OnboardingBloc>()
                                              .add(const RecordingStarted(
                                                  MediaType.audio)),
                                          onVideoRec: () => context
                                              .read<OnboardingBloc>()
                                              .add(const RecordingStarted(
                                                  MediaType.video)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      flex: 2,
                                      child: CustomButton(
                                        btnname: 'Next',
                                        icon: SvgPicture.asset(Assets.nextIcon),
                                        onPressed: isRecording || !isRecorded
                                            ? null
                                            : () {
                                                Navigator.pushNamed(
                                                    context, '/nextStep');
                                              },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            AppDimensions.spacingSmall,
                          ],
                        ),
                      ),
                    ),
                  )),
            ],
          );
        },
      ),
    );
  }
}
