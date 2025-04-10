import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_surveys/domain/enums/survey_status.dart';
import 'package:school_surveys/view/home/cubit/survey_tab_cubit.dart';

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

                return ListTile(
                  title: Text(survey.name),
                  subtitle: Text('URN: ${survey.urn}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO: Navigate to survey detail or actions
                  },
                );
              },
            );
        }
      },
    );
  }
}
