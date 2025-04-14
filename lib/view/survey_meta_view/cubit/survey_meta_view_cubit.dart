import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_surveys/core/result.dart';
import 'package:school_surveys/domain/entities/school_data.dart';
import 'package:school_surveys/domain/entities/survey.dart';
import 'package:school_surveys/domain/entities/survey_general_data.dart';
import 'package:school_surveys/domain/repository/survey_repository.dart';

part 'survey_meta_view_state.dart';

class SurveyMetaViewCubit extends Cubit<SurveyMetaViewState> {
  final SurveyRepository _repository;
  final String surveyId;

  SurveyMetaViewCubit(this._repository, this.surveyId)
    : super(SurveyMetaViewLoading());

  Future<void> load() async {
    final surveyResult = await _repository.getSurveyById(surveyId);
    if (surveyResult is Error) {
      emit(SurveyMetaViewError((surveyResult as Error<Survey?>).error.message));
      return;
    }
    final generalDataResult = await _repository.getGeneralData(surveyId);
    SurveyGeneralData? generalData;
    if (generalDataResult is Ok<SurveyGeneralData?>) {
      generalData = generalDataResult.value;
    }

    final schoolDataResult = await _repository.getSchoolData(surveyId);
    List<SchoolData> schooldata = [];
    if (schoolDataResult is Ok<List<SchoolData>>) {
      schooldata = schoolDataResult.value;
    }

    emit(
      SurveyMetaViewLoaded(
        survey: (surveyResult as Ok<Survey?>).value!,
        generalData: generalData,
        schools: schooldata,
      ),
    );
  }
}
