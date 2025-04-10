import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_surveys/core/result.dart';
import 'package:school_surveys/data/database/data_base_exceptions.dart';
import 'package:school_surveys/domain/entities/survey.dart';
import 'package:school_surveys/domain/enums/survey_status.dart';
import 'package:school_surveys/domain/repository/survey_repository.dart';

class CommencementProgressCubit extends Cubit<CommencementProgressState> {
  CommencementProgressCubit(this._surveyRepository)
    : super(const CommencementProgressState());

  final SurveyRepository _surveyRepository;

  void next() {
    if (state.currentStep < state.totalSteps - 1) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void back() {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  void updateTotalSteps(int totalSteps) {
    emit(state.copyWith(totalSteps: totalSteps));
  }

  Future<void> finishSurvey(String surveyId) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final surveyResult = await _surveyRepository.getSurveyById(surveyId);
    if (surveyResult is Error) {
      final error = surveyResult as Error<Survey?>;
      if (error is RecordNotFoundException) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage:
                "We ran into a problem retrieving your survey. Please try again shortly.",
          ),
        );
        return;
      }
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage:
              "There was a problem completing your survey. Please try again.",
        ),
      );
      return;
    }

    final survey = (surveyResult as Ok<Survey?>).value;
    if (survey == null) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: "Survey not found. Please try again.",
        ),
      );
      return;
    }

    final updatedSurvey = survey.copyWith(status: SurveyStatus.completed);
    final updateResult = await _surveyRepository.updateSurvey(updatedSurvey);

    switch (updateResult) {
      case Ok():
        emit(state.copyWith(isLoading: false, isCompleted: true));
        break;
      case Error():
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage:
                "There was a problem completing your survey. Please try again.",
          ),
        );
        break;
    }
  }
}

class CommencementProgressState extends Equatable {
  final int currentStep;
  final int totalSteps;
  final bool isCompleted;
  final bool isLoading;
  final String? errorMessage;

  const CommencementProgressState({
    this.currentStep = 0,
    this.totalSteps = 1,
    this.isCompleted = false,
    this.isLoading = false,
    this.errorMessage,
  });

  CommencementProgressState copyWith({
    int? currentStep,
    int? totalSteps,
    bool? isCompleted,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CommencementProgressState(
      currentStep: currentStep ?? this.currentStep,
      totalSteps: totalSteps ?? this.totalSteps,
      isCompleted: isCompleted ?? this.isCompleted,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    currentStep,
    totalSteps,
    isCompleted,
    isLoading,
    errorMessage,
  ];
}
