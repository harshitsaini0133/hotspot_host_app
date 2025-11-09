import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intern_assignment/core/app_dimensions.dart';
import 'package:intern_assignment/core/app_textstyles.dart';
import 'package:intern_assignment/feature/experience/ui/bloc/experience_bloc.dart';
import 'package:intern_assignment/feature/experience/ui/widgets/experience_list.dart';
import 'package:intern_assignment/utils/assets.dart';
import 'package:intern_assignment/global_widgets/custom_app_bar.dart';
import 'package:intern_assignment/global_widgets/custom_button.dart';
import 'package:intern_assignment/global_widgets/custom_form_field.dart';

class ExperienceView extends StatelessWidget {
  final TextEditingController textController;
  final ScrollController scrollController;
  final FocusNode focusNode;

  const ExperienceView({
    super.key,
    required this.textController,
    required this.scrollController,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(progress: 0.3),
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
              BlocBuilder<ExperienceBloc, ExperienceState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Padding(
                        padding: AppDimensions.paddingSmall,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text('01', style: AppTextStyles.stepperstyle),
                            AppDimensions.spacingSmall,
                            const Text(
                              'What kind of experiences do you want to host?',
                              style: AppTextStyles.titleStyle,
                            ),
                            SizedBox(
                              height: 130,
                              child: ExperienceList(state: state),
                            ),
                            AppDimensions.spacingLarge,
                            CustomFormField(
                              focusNode: focusNode,
                              maxLines: 5,
                              controller: textController,
                              hintText: '/ Describe your perfect hotspot',
                            ),
                            AppDimensions.spacingMedium,
                            CustomButton(
                              icon: SvgPicture.asset(Assets.nextIcon),
                              btnname: 'Next',
                              onPressed: state.selectedIds.isEmpty
                                  ? null
                                  : () => Navigator.pushNamed(
                                      context, '/onboarding'),
                            ),
                            AppDimensions.spacingMedium,
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
