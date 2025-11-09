import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_assignment/feature/experience/ui/bloc/experience_bloc.dart';
import 'package:intern_assignment/feature/experience/ui/widgets/stamp_card.dart';

class ExperienceList extends StatelessWidget {
  const ExperienceList({
    super.key,
    required this.state,
  });

  final ExperienceState state;

  @override
  Widget build(BuildContext context) {
    if (state.status == ExperienceStatus.loading) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
    if (state.status == ExperienceStatus.failure) {
      return Center(child: Text('Failed to fetch experiences: ${state.error}'));
    }
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: state.experiences.length,
      separatorBuilder: (_, __) => const SizedBox(width: 10),
      itemBuilder: (context, index) {
        final experience = state.experiences[index];
        return Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: ExperienceStampCard(
            experience: experience,
            isSelected: state.selectedIds.contains(experience.id),
            onTap: () {
              if (experience.id != null) {
                context
                    .read<ExperienceBloc>()
                    .add(ExperienceToggled(experience.id!));
              }
            },
          ),
        );
      },
    );
  }
}
