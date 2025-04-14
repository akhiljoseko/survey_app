import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_surveys/core/result.dart';
import 'package:school_surveys/domain/entities/survey_general_data.dart';
import 'package:school_surveys/domain/repository/survey_repository.dart';

part 'general_data_state.dart';

class GeneralDataCubit extends Cubit<GeneralDataState> {
  final SurveyRepository _repository;
  final String surveyId;

  GeneralDataCubit(this._repository, this.surveyId)
    : super(GeneralDataInitial());

  Future<void> loadData() async {
    final existingGeneralDataIfAnyResult = await _repository.getGeneralData(
      surveyId,
    );
    switch (existingGeneralDataIfAnyResult) {
      case Ok<SurveyGeneralData?>():
        if (existingGeneralDataIfAnyResult.value == null) {
          emit(GeneralDataInitial());
        } else {
          emit(GeneralDataLoaded(existingGeneralDataIfAnyResult.value!));
        }
      case Error<SurveyGeneralData?>():
        emit(GeneralDataInitial());
    }
  }

  Future<void> save(String areaName, int numberOfSchools) async {
    final generalDataSaveResult = await _repository.saveGeneralData(
      surveyId: surveyId,
      areaName: areaName,
      numberOfSchools: numberOfSchools,
    );
    switch (generalDataSaveResult) {
      case Ok<SurveyGeneralData>():
        emit(GeneralDataLoaded(generalDataSaveResult.value));
      case Error<SurveyGeneralData>():
        emit(GeneralDataSaveFailure(generalDataSaveResult.error.message));
    }
  }
}
