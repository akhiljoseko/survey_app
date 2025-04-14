part of 'general_data_cubit.dart';

sealed class GeneralDataState extends Equatable {
  const GeneralDataState();

  @override
  List<Object> get props => [];
}

final class GeneralDataInitial extends GeneralDataState {}

class GeneralDataLoaded extends GeneralDataState {
  final SurveyGeneralData data;
  const GeneralDataLoaded(this.data);
  @override
  List<Object> get props => [data];
}

final class GeneralDataSaveFailure extends GeneralDataState {
  final String errorMessage;

  const GeneralDataSaveFailure(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
