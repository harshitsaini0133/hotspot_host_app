part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class RecordingStarted extends OnboardingEvent {
  final MediaType type;
  const RecordingStarted(this.type);
}

class RecordingStopped extends OnboardingEvent {}

class RecordingDeleted extends OnboardingEvent {}

class PlaybackStarted extends OnboardingEvent {}

class PlaybackPaused extends OnboardingEvent {}

class _TimerTicked extends OnboardingEvent {
  final int seconds;
  const _TimerTicked(this.seconds);
}

class _PlayerStatusChanged extends OnboardingEvent {}
