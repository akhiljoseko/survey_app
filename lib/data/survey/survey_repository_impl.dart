import 'package:school_surveys/core/app_exception.dart';
import 'package:school_surveys/core/result.dart';
import 'package:school_surveys/data/survey/survey_exceptions.dart';
import 'package:school_surveys/data/survey/survey_service.dart';
import 'package:school_surveys/domain/entities/survey.dart';
import 'package:school_surveys/domain/enums/survey_status.dart';
import 'package:school_surveys/domain/repository/survey_repository.dart';

class SurveyRepositoryImpl implements SurveyRepository {
  final SurveyService _surveyService;

  SurveyRepositoryImpl({required SurveyService surveyService})
    : _surveyService = surveyService;

  @override
  Future<Result<String>> generateUniqueUrn() async {
    String generateRandomUrn() {
      final random = DateTime.now().millisecondsSinceEpoch.remainder(100000);
      return random.toString().padLeft(5, '0');
    }

    String urn;
    int safetyCounter = 0;

    do {
      urn = generateRandomUrn();
      safetyCounter++;
      if (safetyCounter > 10) {
        return Result.error(SurveyUrnGenerationException());
      }
    } while (await _surveyService.urnExists(urn));

    return Result.ok(urn);
  }

  @override
  Future<Result<Survey>> createSurvey({
    required String urn,
    required String name,
    required String description,
    required DateTime commencementDate,
    required DateTime dueDate,
    required String assignedTo,
    required String assignedBy,
    required String createdBy,
    required SurveyStatus status,
  }) async {
    try {
      final createdSurvey = await _surveyService.createSurvey(
        urn: urn,
        name: name,
        description: description,
        commencementDate: commencementDate,
        dueDate: dueDate,
        assignedTo: assignedTo,
        assignedBy: assignedBy,
        createdBy: createdBy,
        status: status,
      );
      return Result.ok(createdSurvey);
    } on AppException catch (e) {
      return Result.error(e);
    } catch (_) {
      return Result.error(UnknownException());
    }
  }

  @override
  Future<Result<List<Survey>>> getSurveysByStatus(SurveyStatus status) async {
    try {
      final surveys = await _surveyService.getSurveysByStatus(status: status);
      return Result.ok(surveys);
    } on AppException catch (e) {
      return Result.error(e);
    } catch (_) {
      return Result.error(UnknownException());
    }
  }

  @override
  Future<Result<Survey>> updateSurvey(Survey survey) async {
    try {
      final updatedSurvey = await _surveyService.updateSurvey(survey);
      return Result.ok(updatedSurvey);
    } on AppException catch (e) {
      return Result.error(e);
    } catch (_) {
      return Result.error(UnknownException());
    }
  }
}
