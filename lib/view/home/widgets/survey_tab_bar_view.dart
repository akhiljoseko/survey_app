import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:school_surveys/app/routing/app_routes.dart';
import 'package:school_surveys/domain/entities/survey.dart';
import 'package:school_surveys/domain/enums/survey_status.dart';
import 'package:school_surveys/view/home/cubit/survey_tab_cubit.dart';
import 'package:school_surveys/view/home/widgets/survey_list_tile.dart';

class SurveyTabBarView extends StatelessWidget {
  const SurveyTabBarView({super.key, required this.status});

  final SurveyStatus status;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurveyTabCubit, SurveyTabState>(
      builder: (context, state) {
        switch (state) {
          case SurveyTabInitial():
          case SurveyTabLoading():
            return const Center(child: CircularProgressIndicator());
          case SurveyTabEmpty():
            return const Center(child: Text("No surveys found."));
          case SurveyTabError():
            return Center(child: Text(state.message));
          case SurveyTabLoaded():
            return ListView.builder(
              itemCount: state.surveys.length,
              itemBuilder: (context, index) {
                final survey = state.surveys[index];

                return SurveyListTile(
                  survey: survey,
                  onStart: () => _startSurvey(context, survey),
                  onEdit: () => _editSurvey(context, survey),
                );
              },
            );
        }
      },
    );
  }

  void _startSurvey(BuildContext context, Survey survey) {
    context.goNamed(
      AppRoutes.surveyCommencement,
      pathParameters: {"id": survey.id},
    );
  }

  void _editSurvey(BuildContext context, Survey survey) {
    context.goNamed(AppRoutes.editSurvey, pathParameters: {"id": survey.id});
  }
}
