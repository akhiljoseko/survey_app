import 'package:school_surveys/core/app_exception.dart';
import 'package:school_surveys/core/result.dart';
import 'package:school_surveys/data/database/data_base_exceptions.dart';
import 'package:school_surveys/data/survey/survey_exceptions.dart';
import 'package:school_surveys/data/survey/survey_service.dart';
import 'package:school_surveys/domain/entities/school_data.dart';
import 'package:school_surveys/domain/entities/survey.dart';
import 'package:school_surveys/domain/entities/survey_general_data.dart';
import 'package:school_surveys/domain/constants/curriculum.dart';
import 'package:school_surveys/domain/constants/grade_level.dart';
import 'package:school_surveys/domain/constants/school_type.dart';
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

  @override
  Future<Result<SurveyGeneralData?>> getGeneralData(String surveyId) async {
    try {
      final savedGeneralData = await _surveyService.getGeneralData(surveyId);
      return Result.ok(savedGeneralData);
    } on AppException catch (e) {
      return Result.error(e);
    } catch (_) {
      return Result.error(UnknownException());
    }
  }

  @override
  Future<Result<List<SchoolData>>> getSchoolData(String surveyId) async {
    try {
      final schoolDataForSurvey = await _surveyService.getSchoolDataForSurvey(
        surveyId,
      );
      return Result.ok(schoolDataForSurvey);
    } on AppException catch (e) {
      return Result.error(e);
    } catch (_) {
      return Result.error(UnknownException());
    }
  }

  @override
  Future<Result<SurveyGeneralData>> saveGeneralData({
    required String surveyId,
    required String areaName,
    required int numberOfSchools,
  }) async {
    try {
      final savedSurveyGeneralData = await _surveyService.saveSurveyGeneralData(
        surveyId: surveyId,
        areaName: areaName,
        numberOfSchools: numberOfSchools,
      );
      return Result.ok(savedSurveyGeneralData);
    } on AppException catch (e) {
      return Result.error(e);
    } catch (_) {
      return Result.error(UnknownException());
    }
  }

  @override
  Future<Result<SchoolData>> saveSchoolData({
    required String? id,
    required String surveyId,
    required int schoolNumber,
    required String schoolName,
    required SchoolType schoolType,
    required List<Curriculum> curriculum,
    required DateTime establishedOn,
    required List<GradeLevel> gradesPresents,
  }) async {
    try {
      final savedSchoolData = await _surveyService.saveSchoolData(
        id: id,
        surveyId: surveyId,
        schoolNumber: schoolNumber,
        schoolName: schoolName,
        schoolType: schoolType,
        curriculum: curriculum,
        establishedOn: establishedOn,
        gradesPresent: gradesPresents,
      );
      return Result.ok(savedSchoolData);
    } on AppException catch (e) {
      return Result.error(e);
    } catch (_) {
      return Result.error(UnknownException());
    }
  }

  @override
  Future<Result<Survey>> getSurveyById(String surveyId) async {
    try {
      final survey = await _surveyService.getSurveyById(surveyId);
      if (survey == null) {
        return Result.error(RecordNotFoundException());
      }
      return Result.ok(survey);
    } on AppException catch (e) {
      return Result.error(e);
    } catch (_) {
      return Result.error(UnknownException());
    }
  }
}
