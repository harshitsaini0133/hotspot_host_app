import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_assignment/feature/experience/models/experience_model.dart';
import 'package:intern_assignment/feature/experience/data/datasource/experience_service.dart';

part 'experience_event.dart';
part 'experience_state.dart';

class ExperienceBloc extends Bloc<ExperienceEvent, ExperienceState> {
  final ExperienceService _experienceService;

  ExperienceBloc({required ExperienceService experienceService})
      : _experienceService = experienceService,
        super(const ExperienceState()) {
    on<ExperiencesFetched>(_onExperiencesFetched);
    on<ExperienceToggled>(_onExperienceToggled);
  }

  Future<void> _onExperiencesFetched(
    ExperiencesFetched event,
    Emitter<ExperienceState> emit,
  ) async {
    emit(state.copyWith(status: ExperienceStatus.loading));
    try {
      final experiences = await _experienceService.fetchExperiences();
      emit(state.copyWith(
        status: ExperienceStatus.success,
        originalExperiences: experiences,
        experiences: experiences,
      ));
    } catch (e) {
      emit(state.copyWith(
          status: ExperienceStatus.failure, error: e.toString()));
    }
  }

  void _onExperienceToggled(
    ExperienceToggled event,
    Emitter<ExperienceState> emit,
  ) {
    final newSelectedIds = List<int>.from(state.selectedIds);

    if (newSelectedIds.contains(event.experienceId)) {
      newSelectedIds.remove(event.experienceId);
    } else {
      newSelectedIds.add(event.experienceId);
    }

    final selectedExperiences = state.originalExperiences
        .where((exp) => newSelectedIds.contains(exp.id))
        .toList();
    final unselectedExperiences = state.originalExperiences
        .where((exp) => !newSelectedIds.contains(exp.id))
        .toList();

    emit(state.copyWith(
        selectedIds: newSelectedIds,
        experiences: [...selectedExperiences, ...unselectedExperiences]));
  }
}
