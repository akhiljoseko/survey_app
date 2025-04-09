import 'package:school_surveys/data/database/no_sql_local_database.dart';
import 'package:school_surveys/domain/entities/survey.dart';
import 'package:school_surveys/domain/enums/survey_status.dart';
import 'package:uuid/uuid.dart';

const _delayDuration = Duration(milliseconds: 600);

class SurveyService {
  final NoSqlLocalDatabase<Survey> _surveyDatabase;

  SurveyService({required NoSqlLocalDatabase<Survey> surveyDatabase})
    : _surveyDatabase = surveyDatabase;

  Future<Survey> createSurvey({
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
}
