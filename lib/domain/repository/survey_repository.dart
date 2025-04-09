import 'package:school_surveys/core/result.dart';
import 'package:school_surveys/domain/entities/survey.dart';
import 'package:school_surveys/domain/enums/survey_status.dart';

abstract interface class SurveyRepository {
  Future<Result<String>> generateUniqueUrn();

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
  });
}
