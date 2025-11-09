import 'dart:async';
import 'package:dio/dio.dart';
import 'package:intern_assignment/feature/experience/models/experience_model.dart';
import 'package:intern_assignment/core/api_client.dart';
import 'package:intern_assignment/utils/logger.dart';

class ExperienceService {
  final ApiClient client = ApiClient();

  Future<List<Experience>> fetchExperiences() async {
    try {
      final response = await client.dio.get(
        'experiences',
        queryParameters: {'active': true},
      );
      final getExperienceData = GetExperienceData.fromMap(response.data);
      return getExperienceData.data?.experiences ?? [];
    } on DioException catch (e) {
      Logger.d('ExperienceService', 'Error fetching experiences: $e');
      return [];
    }
  }
}
