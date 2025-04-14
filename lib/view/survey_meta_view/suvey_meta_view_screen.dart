import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_surveys/domain/repository/survey_repository.dart';
import 'package:school_surveys/view/survey_meta_view/cubit/survey_meta_view_cubit.dart';
import 'package:school_surveys/view/widgets/spacing.dart';

class SurveyMetaViewScreen extends StatelessWidget {
  final String surveyId;

  const SurveyMetaViewScreen({super.key, required this.surveyId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              SurveyMetaViewCubit(context.read<SurveyRepository>(), surveyId)
                ..load(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Survey Details")),
        body: BlocBuilder<SurveyMetaViewCubit, SurveyMetaViewState>(
          builder: (context, state) {
            if (state is SurveyMetaViewLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SurveyMetaViewError) {
              return Center(child: Text(state.message));
            } else if (state is SurveyMetaViewLoaded) {
              final survey = state.survey;
              final general = state.generalData;
              final schools = state.schools;

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _sectionCard(
                    context,
                    title: "Survey Metadata",
                    children: [
                      _MetaTile("URN", survey.urn),
                      _MetaTile("Status", survey.status.name),
                      _MetaTile("Assigned To", survey.assignedTo.displayName),
                      _MetaTile("Assigned By", survey.assignedBy.displayName),
                      _MetaTile("Due Date", _formatDate(survey.dueDate)),
                      _MetaTile(
                        "Commencement Date",
                        _formatDate(survey.commencementDate),
                      ),
                      Vspace(12),
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Vspace(4),
                      Text(
                        survey.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),

                  const Vspace(20),
                  _sectionCard(
                    context,
                    title: "General Survey Info",
                    children:
                        general != null
                            ? [
                              _MetaTile("Area Name", general.areaName),
                              _MetaTile(
                                "Number of Schools",
                                general.numberOfSchools.toString(),
                              ),
                            ]
                            : [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  "No general data available",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                  ),

                  const Vspace(20),
                  _sectionCard(
                    context,
                    title: "School Details",
                    children:
                        schools.isEmpty
                            ? [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  "No school data available",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ]
                            : schools.map((school) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "School ${school.schoolNumber}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    _MetaTile("Name", school.schoolName),
                                    _MetaTile("Type", school.schoolType.label),
                                    _MetaTile(
                                      "Established",
                                      _formatDate(school.establishedOn),
                                    ),
                                    _MetaTile(
                                      "Curriculum",
                                      school.curriculum
                                          .map((c) => c.label)
                                          .join(', '),
                                    ),
                                    _MetaTile(
                                      "Grades",
                                      school.gradesPresent
                                          .map((g) => g.label)
                                          .join(', '),
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              );
                            }).toList(),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _sectionCard(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Divider(height: 20),
            ...children,
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "—";
    return "${date.day}/${date.month}/${date.year}";
  }
}

class _MetaTile extends StatelessWidget {
  const _MetaTile(this.title, this.value);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(value, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
