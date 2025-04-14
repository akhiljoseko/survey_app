part of 'survey_meta_view_cubit.dart';

sealed class SurveyMetaViewState extends Equatable {
  const SurveyMetaViewState();

  @override
  List<Object?> get props => [];
}

final class SurveyMetaViewLoading extends SurveyMetaViewState {}

final class SurveyMetaViewLoaded extends SurveyMetaViewState {
  final Survey survey;
  final SurveyGeneralData? generalData;
  final List<SchoolData> schools;

  const SurveyMetaViewLoaded({
    required this.survey,
    this.generalData,
    this.schools = const [],
  });

  @override
  List<Object?> get props => [survey, generalData, schools];
}

final class SurveyMetaViewError extends SurveyMetaViewState {
  final String message;

  const SurveyMetaViewError(this.message);

  @override
  List<Object?> get props => [message];
}
