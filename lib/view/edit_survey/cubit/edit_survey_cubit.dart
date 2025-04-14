import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_surveys/domain/entities/survey.dart';
import 'package:school_surveys/domain/entities/user.dart';
import 'package:school_surveys/domain/repository/survey_repository.dart';
import 'package:school_surveys/core/result.dart';

part 'edit_survey_state.dart';

class EditSurveyCubit extends Cubit<EditSurveyState> {
  final SurveyRepository _surveyRepository;

  EditSurveyCubit(this._surveyRepository) : super(EditSurveyInitial());

  Future<void> fetchSurveyById(String id) async {
    emit(EditSurveyLoading());
    final result = await _surveyRepository.getSurveyById(id);
    switch (result) {
      case Ok<Survey?>():
        emit(EditSurveyLoaded(result.value!));
        break;
      case Error<Survey?>():
        emit(EditSurveyFailure(result.error.message));
    }
  }

  Future<void> updateSurvey({
    required String surveyId,
    required String urn,
    required String name,
    required String description,
    required DateTime startDate,
    required DateTime dueDate,
    required User assignedTo,
    required User assignedBy,
  }) async {
    final survey = (state as EditSurveyLoaded).survey;
    emit(EditSurveyLoading());
    final updatedSurvey = Survey(
      id: surveyId,
      createdAt: survey.createdAt,
      urn: urn,
      name: name,
      description: description,
      commencementDate: startDate,
      dueDate: dueDate,
      assignedTo: assignedTo,
      assignedBy: assignedBy,
      createdBy: survey.createdBy,
      status: survey.status,
    );
    final result = await _surveyRepository.updateSurvey(updatedSurvey);

    switch (result) {
      case Ok<Survey>():
        emit(EditSurveySuccess());
        break;
      case Error<Survey>():
        emit(EditSurveyFailure(result.error.message));
    }
  }
}
