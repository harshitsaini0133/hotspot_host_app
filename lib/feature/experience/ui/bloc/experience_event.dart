part of 'experience_bloc.dart';

abstract class ExperienceEvent extends Equatable {
  const ExperienceEvent();

  @override
  List<Object> get props => [];
}

class ExperiencesFetched extends ExperienceEvent {}

class ExperienceToggled extends ExperienceEvent {
  final int experienceId;

  const ExperienceToggled(this.experienceId);

  @override
  List<Object> get props => [experienceId];
}
