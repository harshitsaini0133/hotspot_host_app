part of 'experience_bloc.dart';

enum ExperienceStatus { initial, loading, success, failure }

class ExperienceState extends Equatable {
  const ExperienceState({
    this.status = ExperienceStatus.initial,
    this.experiences = const <Experience>[],
    this.originalExperiences = const <Experience>[],
    this.selectedIds = const <int>[],
    this.error = '',
  });

  final ExperienceStatus status;
  final List<Experience> experiences;
  final List<Experience> originalExperiences;
  final List<int> selectedIds;
  final String error;

  ExperienceState copyWith({
    ExperienceStatus? status,
    List<Experience>? experiences,
    List<Experience>? originalExperiences,
    List<int>? selectedIds,
    String? error,
  }) {
    return ExperienceState(
      status: status ?? this.status,
      experiences: experiences ?? this.experiences,
      originalExperiences: originalExperiences ?? this.originalExperiences,
      selectedIds: selectedIds ?? this.selectedIds,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props =>
      [status, experiences, originalExperiences, selectedIds, error];
}
