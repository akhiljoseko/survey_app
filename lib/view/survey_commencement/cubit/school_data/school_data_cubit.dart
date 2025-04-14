import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:school_surveys/core/result.dart';
import 'package:school_surveys/domain/entities/school_data.dart';
import 'package:school_surveys/domain/constants/curriculum.dart';
import 'package:school_surveys/domain/constants/grade_level.dart';
import 'package:school_surveys/domain/constants/school_type.dart';
import 'package:school_surveys/domain/repository/survey_repository.dart';

part 'school_data_state.dart';

class SchoolDataCubit extends Cubit<SchoolDataState> {
  final SurveyRepository _repository;
  final String surveyId;

  SchoolDataCubit(this._repository, this.surveyId) : super(SchoolDataInitial());

  Future<void> loadSchools() async {
    final existingSchoolDataResult = await _repository.getSchoolData(surveyId);
    switch (existingSchoolDataResult) {
      case Ok<List<SchoolData>>():
        emit(SchoolDataLoaded(existingSchoolDataResult.value));
      case Error<List<SchoolData>>():
        emit(SchoolDataLoaded([]));
    }
  }

  Future<void> saveSchool({
    required int schoolNumber,
    required String schoolName,
    required SchoolType schoolType,
    required List<Curriculum> curriculum,
    required DateTime establishedOn,
    required List<GradeLevel> gradesPresents,
  }) async {
    final current =
        state is SchoolDataLoaded
            ? (state as SchoolDataLoaded).schools
            : <SchoolData>[];

    emit(SchoolDataSaveInProgress());

    final schoolDataIfExists =
        current.length >= schoolNumber ? current[schoolNumber - 1] : null;
    final savedSchoolDataResult = await _repository.saveSchoolData(
      id: schoolDataIfExists?.id,
      surveyId: surveyId,
      schoolNumber: schoolNumber,
      schoolName: schoolName,
      schoolType: schoolType,
      curriculum: curriculum,
      establishedOn: establishedOn,
      gradesPresents: gradesPresents,
    );

    switch (savedSchoolDataResult) {
      case Ok<SchoolData>():
        final updated = List<SchoolData>.from(current);
        final index = updated.indexWhere((s) => s.schoolNumber == schoolNumber);
        if (index >= 0) {
          updated[index] = savedSchoolDataResult.value;
        } else {
          updated.add(savedSchoolDataResult.value);
        }
        emit(SchoolDataLoaded(updated));
      case Error<SchoolData>():
        emit(
          SchoolDataSaveFailure(
            errorMessage: savedSchoolDataResult.error.message,
          ),
        );
    }
  }

  List<SchoolData> get currentSchools =>
      state is SchoolDataLoaded ? (state as SchoolDataLoaded).schools : [];

  SchoolData? getSchoolData(index) {
    return currentSchools.firstWhereOrNull((sc) => sc.schoolNumber == index);
  }
}
