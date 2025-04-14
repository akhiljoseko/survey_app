part of 'edit_survey_cubit.dart';

sealed class EditSurveyState extends Equatable {
  const EditSurveyState();

  @override
  List<Object?> get props => [];
}

final class EditSurveyInitial extends EditSurveyState {}

final class EditSurveyLoading extends EditSurveyState {}

final class EditSurveySuccess extends EditSurveyState {}

final class EditSurveyFailure extends EditSurveyState {
  final String message;

  const EditSurveyFailure(this.message);

  @override
  List<Object?> get props => [message];
}

final class EditSurveyLoaded extends EditSurveyState {
  final Survey survey;

  const EditSurveyLoaded(this.survey);

  @override
  List<Object?> get props => [survey];
}
