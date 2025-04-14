import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:school_surveys/app/routing/app_routes.dart';
import 'package:school_surveys/domain/enums/survey_status.dart';
import 'package:school_surveys/domain/repository/survey_repository.dart';
import 'package:school_surveys/view/home/cubit/survey_tab_cubit.dart';
import 'package:school_surveys/view/home/widgets/survey_tab_bar_view.dart';
import 'package:school_surveys/view/widgets/user_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.tabIndex});

  final String? tabIndex;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 3, vsync: this);

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    if (widget.tabIndex != oldWidget.tabIndex) {
      final index = int.tryParse(widget.tabIndex ?? "0") ?? 0;
      _tabController.animateTo(index);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.goNamed(AppRoutes.addSurvey);
        },
        label: Text("Add Survey"),
        icon: Icon(Icons.add_rounded),
      ),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Surveys",
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [UserButton()],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Scheduled"),
            Tab(text: "Completed"),
            Tab(text: "With-held"),
          ],
        ),
      ),

      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            BlocProvider(
              create:
                  (context) => SurveyTabCubit(
                    context.read<SurveyRepository>(),
                    SurveyStatus.scheduled,
                  ),
              child: SurveyTabBarView(status: SurveyStatus.scheduled),
            ),
            BlocProvider(
              create:
                  (context) => SurveyTabCubit(
                    context.read<SurveyRepository>(),
                    SurveyStatus.completed,
                  ),
              child: SurveyTabBarView(status: SurveyStatus.completed),
            ),
            BlocProvider(
              create:
                  (context) => SurveyTabCubit(
                    context.read<SurveyRepository>(),
                    SurveyStatus.withheld,
                  ),
              child: SurveyTabBarView(status: SurveyStatus.withheld),
            ),
          ],
        ),
      ),
    );
  }
}
