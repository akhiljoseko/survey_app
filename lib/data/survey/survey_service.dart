import 'package:school_surveys/core/app_exception.dart';
import 'package:school_surveys/data/database/no_sql_local_database.dart';
import 'package:school_surveys/domain/entities/school_data.dart';
import 'package:school_surveys/domain/entities/survey.dart';
import 'package:school_surveys/domain/entities/survey_general_data.dart';
import 'package:school_surveys/domain/constants/curriculum.dart';
import 'package:school_surveys/domain/constants/grade_level.dart';
import 'package:school_surveys/domain/constants/school_type.dart';
import 'package:school_surveys/domain/entities/user.dart';
import 'package:school_surveys/domain/enums/survey_status.dart';
import 'package:uuid/uuid.dart';

const _delayDuration = Duration(milliseconds: 600);

class SurveyService {
  final NoSqlLocalDatabase<Survey> _surveyDatabase;
  final NoSqlLocalDatabase<SurveyGeneralData> _surveyGeneralDataDatabase;
  final NoSqlLocalDatabase<SchoolData> _surveySchoolDataDatabase;

  SurveyService({
    required NoSqlLocalDatabase<Survey> surveyDatabase,
    required NoSqlLocalDatabase<SurveyGeneralData> surveyGeneralDataDatabase,
    required NoSqlLocalDatabase<SchoolData> surveySchoolDataDatabase,
  }) : _surveyDatabase = surveyDatabase,
       _surveyGeneralDataDatabase = surveyGeneralDataDatabase,
       _surveySchoolDataDatabase = surveySchoolDataDatabase;

  Future<Survey> createSurvey({
    required String urn,
    required String name,
    required String description,
    required DateTime commencementDate,
    required DateTime dueDate,
    required User assignedTo,
    required User assignedBy,
    required String createdBy,
    required SurveyStatus status,
  }) async {
    await Future.delayed(_delayDuration);
    final id = Uuid().v4();
    final survey = Survey(
      id: id,
      createdAt: DateTime.now().toUtc(),
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
    final createdSurvey = await _surveyDatabase.insert(survey);
    return createdSurvey;
  }

  Future<bool> urnExists(String urn) async {
    return _surveyDatabase.getAll().then(
      (surveys) => surveys.any((survey) => survey.urn == urn),
    );
  }

  Future<List<Survey>> getSurveysByStatus({
    required SurveyStatus status,
  }) async {
    await Future.delayed(_delayDuration);
    final allSurveys = await _surveyDatabase.getAll();
    return allSurveys.where((sr) => sr.status == status).toList();
  }

  Future<Survey> updateSurvey(Survey survey) async {
    await Future.delayed(_delayDuration);
    return await _surveyDatabase.update(survey.id, survey);
  }

  Future<SurveyGeneralData?> getGeneralData(String surveyId) async {
    return await _surveyGeneralDataDatabase.getById(surveyId);
  }

  Future<List<SchoolData>> getSchoolDataForSurvey(String surveyId) async {
    final schoolData = await _surveySchoolDataDatabase.getAll();
    return schoolData.where((sd) => sd.surveyId == surveyId).toList();
  }

  Future<SurveyGeneralData> saveSurveyGeneralData({
    required String surveyId,
    required String areaName,
    required int numberOfSchools,
  }) async {
    final generalData = SurveyGeneralData(
      id: surveyId,
      createdAt: DateTime.now().toUtc(),
      areaName: areaName,
      numberOfSchools: numberOfSchools,
    );
    try {
      return await _surveyGeneralDataDatabase.update(surveyId, generalData);
    } on AppException catch (_) {
      return await _surveyGeneralDataDatabase.insert(generalData);
    }
  }

  Future<SchoolData> saveSchoolData({
    required String? id,
    required String surveyId,
    required int schoolNumber,
    required String schoolName,
    required SchoolType schoolType,
    required List<Curriculum> curriculum,
    required DateTime establishedOn,
    required List<GradeLevel> gradesPresent,
  }) async {
    if (id != null) {
      final existingSchoolData = await _surveySchoolDataDatabase.getById(id);
      if (existingSchoolData != null) {
        final dataTobeUpdated = SchoolData(
          id: id,
          createdAt: existingSchoolData.createdAt,
          surveyId: surveyId,
          schoolNumber: schoolNumber,
          schoolName: schoolName,
          schoolType: schoolType,
          curriculum: curriculum,
          establishedOn: establishedOn,
          gradesPresent: gradesPresent,
        );
        return await _surveySchoolDataDatabase.update(id, dataTobeUpdated);
      }
    }
    //Here we know that the school data doesn't exist so we will add a new record
    final schoolData = SchoolData(
      id: Uuid().v4(),
      createdAt: DateTime.now().toUtc(),
      surveyId: surveyId,
      schoolNumber: schoolNumber,
      schoolName: schoolName,
      schoolType: schoolType,
      curriculum: curriculum,
      establishedOn: establishedOn,
      gradesPresent: gradesPresent,
    );
    return await _surveySchoolDataDatabase.insert(schoolData);
  }

  Future<Survey?> getSurveyById(String surveyId) async {
    return await _surveyDatabase.getById(surveyId);
  }
}
