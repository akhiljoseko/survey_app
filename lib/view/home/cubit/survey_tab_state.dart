part of 'survey_tab_cubit.dart';

sealed class SurveyTabState extends Equatable {
  const SurveyTabState();

  @override
  List<Object> get props => [];
}

final class SurveyTabInitial extends SurveyTabState {}

final class SurveyTabLoading extends SurveyTabState {}

final class SurveyTabEmpty extends SurveyTabState {}

final class SurveyTabLoaded extends SurveyTabState {
  final List<Survey> surveys;

  const SurveyTabLoaded(this.surveys);
  @override
  List<Object> get props => [surveys];
}

final class SurveyTabError extends SurveyTabState {
  final String message;

  const SurveyTabError(this.message);
  @override
  List<Object> get props => [message];
}
