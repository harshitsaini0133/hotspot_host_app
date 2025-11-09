part of 'onboarding_bloc.dart';

enum OnboardingStatus {
  initial,
  loading,
  recording,
  playing,
  paused,
  recorded,
  failure
}

class OnboardingState extends Equatable {
  const OnboardingState({
    this.status = OnboardingStatus.initial,
    this.seconds = 0,
    this.recordingPath,
    this.recordingType,
    this.thumbnailPath,
    this.errorMessage,
  });

  final OnboardingStatus status;
  final int seconds;
  final String? recordingPath;
  final MediaType? recordingType;
  final String? thumbnailPath;
  final String? errorMessage;

  OnboardingState copyWith({
    OnboardingStatus? status,
    int? seconds,
    String? recordingPath,
    MediaType? recordingType,
    String? thumbnailPath,
    String? errorMessage,
    bool clearRecording = false,
  }) {
    return OnboardingState(
      status: status ?? this.status,
      seconds: seconds ?? this.seconds,
      recordingPath:
          clearRecording ? null : recordingPath ?? this.recordingPath,
      recordingType:
          clearRecording ? null : recordingType ?? this.recordingType,
      thumbnailPath:
          clearRecording ? null : thumbnailPath ?? this.thumbnailPath,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        seconds,
        recordingPath,
        recordingType,
        thumbnailPath,
        errorMessage,
      ];
}
