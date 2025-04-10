import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_surveys/core/result.dart';
import 'package:school_surveys/domain/entities/survey.dart';
import 'package:school_surveys/domain/enums/survey_status.dart';
import 'package:school_surveys/domain/repository/survey_repository.dart';

part 'survey_tab_state.dart';

class SurveyTabCubit extends Cubit<SurveyTabState> {
  final SurveyRepository _surveyRepository;
  final SurveyStatus status;

  SurveyTabCubit(this._surveyRepository, this.status)
    : super(SurveyTabInitial()) {
    loadSurveys();
  }

  Future<void> loadSurveys() async {
    emit(SurveyTabLoading());

    final surveysResult = await _surveyRepository.getSurveysByStatus(status);

    switch (surveysResult) {
      case Ok<List<Survey>>():
        if (surveysResult.value.isEmpty) {
          emit(SurveyTabEmpty());
        } else {
          emit(SurveyTabLoaded(surveysResult.value));
        }
      case Error<List<Survey>>():
        emit(SurveyTabError(surveysResult.error.message));
    }
  }
}
