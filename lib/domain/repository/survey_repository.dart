import 'package:school_surveys/core/result.dart';
import 'package:school_surveys/domain/entities/school_data.dart';
import 'package:school_surveys/domain/entities/survey.dart';
import 'package:school_surveys/domain/entities/survey_general_data.dart';
import 'package:school_surveys/domain/constants/curriculum.dart';
import 'package:school_surveys/domain/constants/grade_level.dart';
import 'package:school_surveys/domain/constants/school_type.dart';
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

  Future<Result<List<Survey>>> getSurveysByStatus(SurveyStatus status);

  Future<Result<Survey>> updateSurvey(Survey survey);

  Future<Result<SurveyGeneralData>> saveGeneralData({
    required String surveyId,
    required String areaName,
    required int numberOfSchools,
  });

  Future<Result<SurveyGeneralData?>> getGeneralData(String surveyId);

  Future<Result<List<SchoolData>>> getSchoolData(String surveyId);

  Future<Result<SchoolData>> saveSchoolData({
    required String? id,
    required String surveyId,
    required int schoolNumber,
    required String schoolName,
    required SchoolType schoolType,
    required List<Curriculum> curriculum,
    required DateTime establishedOn,
    required List<GradeLevel> gradesPresents,
  });

  Future<Result<Survey?>> getSurveyById(String surveyId);
}
