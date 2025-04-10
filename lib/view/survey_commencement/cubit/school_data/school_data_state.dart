part of 'school_data_cubit.dart';

sealed class SchoolDataState extends Equatable {
  const SchoolDataState();

  @override
  List<Object> get props => [];
}

final class SchoolDataInitial extends SchoolDataState {}

final class SchoolDataSaveInProgress extends SchoolDataState {}

class SchoolDataLoaded extends SchoolDataState {
  final List<SchoolData> schools;
  const SchoolDataLoaded(this.schools);
}

final class SchoolDataSaveFailure extends SchoolDataState {
  final String errorMessage;

  const SchoolDataSaveFailure({required this.errorMessage});
}
