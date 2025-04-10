import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_surveys/core/result.dart';
import 'package:school_surveys/domain/entities/survey.dart';
import 'package:school_surveys/domain/enums/survey_status.dart';
import 'package:school_surveys/domain/repository/survey_repository.dart';
import 'package:school_surveys/utils/snackbar_utils.dart';
import 'package:school_surveys/view/home/cubit/survey_tab_cubit.dart';

/// --- State Definitions ---

abstract class SurveyActionState {
  const SurveyActionState();
}

class SurveyActionIdle extends SurveyActionState {}

class SurveyActionInProgress extends SurveyActionState {}

class SurveyActionSuccess extends SurveyActionState {}

class SurveyActionFailure extends SurveyActionState {
  final String message;
  const SurveyActionFailure(this.message);
}

/// --- Cubit Definition ---

class SurveyActionCubit extends Cubit<SurveyActionState> {
  final SurveyRepository _repository;

  SurveyActionCubit(this._repository) : super(SurveyActionIdle());

  Future<void> deleteSurvey(Survey survey) async {
    emit(SurveyActionInProgress());
    final withHelSurvey = survey.copyWith(status: SurveyStatus.withheld);
    final deleteResult = await _repository.updateSurvey(withHelSurvey);
    switch (deleteResult) {
      case Ok<Survey>():
        emit(SurveyActionSuccess());
      case Error<Survey>():
        emit(SurveyActionFailure(deleteResult.error.message));
    }
  }
}

/// --- Widget ---

class SurveyListTile extends StatelessWidget {
  final Survey survey;
  final VoidCallback onStart;
  final VoidCallback onEdit;

  const SurveyListTile({
    super.key,
    required this.survey,
    required this.onStart,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SurveyActionCubit(context.read<SurveyRepository>()),
      child: BlocConsumer<SurveyActionCubit, SurveyActionState>(
        listener: (context, state) {
          if (state is SurveyActionFailure) {
            SnackbarUtils.showErrorSnackbar(context, message: state.message);
          }
          if (state is SurveyActionSuccess) {
            context.read<SurveyTabCubit>().loadSurveys();
          }
        },
        builder: (context, state) {
          final isLoading = state is SurveyActionInProgress;

          return Card(
            elevation: 1.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(survey.name),
              subtitle: Text('URN: ${survey.urn}'),
              trailing:
                  isLoading
                      ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                      : PopupMenuButton<String>(
                        onSelected: (action) {
                          switch (action) {
                            case 'start':
                              onStart();
                              break;
                            case 'edit':
                              onEdit();
                              break;
                            case 'delete':
                              context.read<SurveyActionCubit>().deleteSurvey(
                                survey,
                              );
                              break;
                          }
                        },
                        itemBuilder: (_) => _buildActions(survey),
                      ),
            ),
          );
        },
      ),
    );
  }

  List<PopupMenuEntry<String>> _buildActions(Survey survey) {
    final status = survey.status;
    final actions = <PopupMenuEntry<String>>[];

    if (status == SurveyStatus.scheduled) {
      actions.add(const PopupMenuItem(value: 'start', child: Text('Start')));
      actions.add(const PopupMenuItem(value: 'edit', child: Text('Edit')));
      actions.add(const PopupMenuItem(value: 'delete', child: Text('Delete')));
    } else if (status == SurveyStatus.completed) {
      actions.add(const PopupMenuItem(value: 'delete', child: Text('Delete')));
    } else if (status == SurveyStatus.withheld) {
      actions.add(const PopupMenuItem(value: 'edit', child: Text('Edit')));
      actions.add(const PopupMenuItem(value: 'start', child: Text('Start')));
    }

    return actions;
  }
}
