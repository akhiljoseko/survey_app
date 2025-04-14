import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:school_surveys/app/routing/app_routes.dart';
import 'package:school_surveys/domain/repository/survey_repository.dart';
import 'package:school_surveys/utils/snackbar_utils.dart';
import 'package:school_surveys/view/survey_commencement/cubit/commencement_progress/commencement_progress_cubit.dart';
import 'package:school_surveys/view/survey_commencement/cubit/general_data/general_data_cubit.dart';
import 'package:school_surveys/view/survey_commencement/cubit/school_data/school_data_cubit.dart';
import 'package:school_surveys/view/widgets/user_button.dart';
import 'general_data_page.dart';
import 'school_data_page.dart';

class SurveyCommencementScreen extends StatelessWidget {
  final String surveyId;

  const SurveyCommencementScreen({super.key, required this.surveyId});

  @override
  Widget build(BuildContext context) {
    final repository = context.read<SurveyRepository>();

    return Scaffold(
      appBar: AppBar(actions: [UserButton()]),
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => GeneralDataCubit(repository, surveyId)..loadData(),
            ),
            BlocProvider(
              create:
                  (_) => SchoolDataCubit(repository, surveyId)..loadSchools(),
            ),
            BlocProvider(create: (_) => CommencementProgressCubit(repository)),
          ],
          child: _SurveyCommencementContent(surveyId),
        ),
      ),
    );
  }
}

class _SurveyCommencementContent extends StatefulWidget {
  final String surveyId;
  const _SurveyCommencementContent(this.surveyId);

  @override
  State<_SurveyCommencementContent> createState() =>
      _SurveyCommencementContentState();
}

class _SurveyCommencementContentState
    extends State<_SurveyCommencementContent> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(keepPage: false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommencementProgressCubit, CommencementProgressState>(
      listener: (context, state) {
        _controller.jumpToPage(state.currentStep);
        if (state.errorMessage != null) {
          SnackbarUtils.showErrorSnackbar(
            context,
            message: state.errorMessage!,
          );
        }
        if (state.isCompleted) {
          context.goNamed(AppRoutes.home, queryParameters: {"tab": "1"});
        }
      },
      child: Column(
        children: [
          _ProgressHeader(),
          Expanded(
            child: BlocBuilder<
              CommencementProgressCubit,
              CommencementProgressState
            >(
              builder: (context, state) {
                return PageView.builder(
                  controller: _controller,
                  itemCount: state.totalSteps,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return GeneralDataPage();
                    } else {
                      final isLastSchool = index == state.totalSteps - 1;
                      return SchoolDataPage(
                        index: index,
                        onBack:
                            () =>
                                context
                                    .read<CommencementProgressCubit>()
                                    .back(),
                        onNext: () {
                          if (isLastSchool) {
                            _finishSurvey(context);
                          } else {
                            context.read<CommencementProgressCubit>().next();
                          }
                        },
                        isLast: isLastSchool,
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _finishSurvey(BuildContext context) {
    context.read<CommencementProgressCubit>().finishSurvey(widget.surveyId);
  }
}

class _ProgressHeader extends StatelessWidget {
  const _ProgressHeader();

  @override
  Widget build(BuildContext context) {
    return BlocListener<GeneralDataCubit, GeneralDataState>(
      listener: (context, state) {
        if (state is GeneralDataLoaded) {
          context.read<CommencementProgressCubit>().updateTotalSteps(
            state.data.numberOfSchools + 1,
          );
        }
      },
      child: BlocBuilder<CommencementProgressCubit, CommencementProgressState>(
        builder: (context, state) {
          return SizedBox(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(state.totalSteps, (index) {
                final isActive = index == state.currentStep;
                final isComplete = index < state.currentStep;
                final theme = Theme.of(context);
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor:
                              isActive
                                  ? theme.colorScheme.primary
                                  : isComplete
                                  ? Colors.green
                                  : Colors.grey.shade300,
                          child: Text(
                            index == 0 ? "G" : '$index',
                            style: TextStyle(
                              color:
                                  isActive || isComplete
                                      ? Colors.white
                                      : Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          index == 0 ? "General" : "School-$index",
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                isActive
                                    ? theme.colorScheme.primary
                                    : isComplete
                                    ? Colors.green
                                    : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
