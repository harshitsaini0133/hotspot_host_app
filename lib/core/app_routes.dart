import 'package:flutter/material.dart';
import 'package:intern_assignment/feature/experience/ui/screens/experience_screen.dart';
import 'package:intern_assignment/feature/onboarding/ui/screens/onboarding_screen.dart';

class AppRoutes {
  static const String experience = '/';
  static const String onboarding = '/onboarding';

  static Map<String, WidgetBuilder> get routes => {
        experience: (_) => const ExperienceScreen(),
        onboarding: (_) => const OnboardingScreen(),
      };
}
