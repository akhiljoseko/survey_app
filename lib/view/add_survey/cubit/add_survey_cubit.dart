import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_surveys/core/result.dart';
import 'package:school_surveys/domain/entities/survey.dart';
import 'package:school_surveys/domain/enums/survey_status.dart';
import 'package:school_surveys/domain/repository/survey_repository.dart';

part 'add_survey_state.dart';

class AddSurveyCubit extends Cubit<AddSurveyState> {
  final SurveyRepository _surveyRepository;
  late final String _urn;

  AddSurveyCubit(this._surveyRepository) : super(AddSurveyInitial()) {
    _generateUrn();
  }

  void _generateUrn() async {
    emit(AddSurveyLoading());
    final urnResult = await _surveyRepository.generateUniqueUrn();
    switch (urnResult) {
      case Ok<String>():
        _urn = urnResult.value;
        emit(AddSurveyUrnGenerated(urnResult.value));
      case Error<String>():
        emit(AddSurveyFailure(urnResult.error.message));
    }
  }

  Future<void> submitSurvey({
    required String name,
    required String description,
    required DateTime startDate,
    required DateTime dueDate,
    required String assignedTo,
    required String assignedBy,
    required String createdBy,
  }) async {
    emit(AddSurveyLoading());

    final surveyResult = await _surveyRepository.createSurvey(
      urn: _urn,
      name: name,
      description: description,
      commencementDate: startDate,
      dueDate: dueDate,
      assignedTo: assignedTo,
      assignedBy: assignedBy,
      createdBy: createdBy,
      status: SurveyStatus.scheduled,
    );
    switch (surveyResult) {
      case Ok<Survey>():
        emit(AddSurveySuccess());
        break;
      case Error<Survey>():
        emit(AddSurveyFailure(surveyResult.error.message));
    }
  }
}
