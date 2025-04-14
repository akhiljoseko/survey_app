import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_surveys/domain/repository/survey_repository.dart';
import 'package:school_surveys/view/survey_meta_view/cubit/survey_meta_view_cubit.dart';

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
              final s = state.survey;
              final general = state.generalData;
              final schools = state.schools;

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _sectionCard(
                    title: "Survey Metadata",
                    children: [
                      _metaTile("URN", s.urn),
                      _metaTile("Status", s.status.name),
                      _metaTile("Assigned To", s.assignedTo),
                      _metaTile("Assigned By", s.assignedBy),
                      _metaTile("Due Date", _formatDate(s.dueDate)),
                      _metaTile(
                        "Commencement Date",
                        _formatDate(s.commencementDate),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  _sectionCard(
                    title: "General Survey Info",
                    children:
                        general != null
                            ? [
                              _metaTile("Area Name", general.areaName),
                              _metaTile(
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

                  const SizedBox(height: 20),
                  _sectionCard(
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
                                    _metaTile("Name", school.schoolName),
                                    _metaTile("Type", school.schoolType.label),
                                    _metaTile(
                                      "Established",
                                      _formatDate(school.establishedOn),
                                    ),
                                    _metaTile(
                                      "Curriculum",
                                      school.curriculum
                                          .map((c) => c.label)
                                          .join(', '),
                                    ),
                                    _metaTile(
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

  Widget _metaTile(String title, String value) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
      ),
      subtitle: Text(value, style: const TextStyle(fontSize: 14)),
    );
  }

  Widget _sectionCard({required String title, required List<Widget> children}) {
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
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
