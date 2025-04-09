part of 'add_survey_cubit.dart';

sealed class AddSurveyState extends Equatable {
  const AddSurveyState();

  @override
  List<Object> get props => [];
}

final class AddSurveyInitial extends AddSurveyState {}

final class AddSurveyUrnGenerated extends AddSurveyState {
  final String urn;

  const AddSurveyUrnGenerated(this.urn);
}

final class AddSurveyLoading extends AddSurveyState {}

final class AddSurveySuccess extends AddSurveyState {}

class AddSurveyFailure extends AddSurveyState {
  final String message;
  const AddSurveyFailure(this.message);
}
