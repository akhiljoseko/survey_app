import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:school_surveys/domain/entities/survey.dart';
import 'package:school_surveys/domain/entities/user.dart';
import 'package:school_surveys/domain/repository/authentication_repository.dart';
import 'package:school_surveys/domain/repository/survey_repository.dart';
import 'package:school_surveys/utils/snackbar_utils.dart';
import 'package:school_surveys/view/edit_survey/cubit/edit_survey_cubit.dart';
import 'package:school_surveys/view/add_survey/survey_from_validations.dart';
import 'package:school_surveys/view/widgets/user_button.dart';
import 'package:school_surveys/view/widgets/inline_date_input_field.dart';
import 'package:school_surveys/view/widgets/primary_button.dart';
import 'package:school_surveys/view/widgets/spacing.dart';
import 'package:school_surveys/view/widgets/user_drop_down_button.dart';

class EditSurveyScreen extends StatefulWidget {
  final String surveyId;

  const EditSurveyScreen({super.key, required this.surveyId});

  @override
  State<EditSurveyScreen> createState() => _EditSurveyScreenState();
}

class _EditSurveyScreenState extends State<EditSurveyScreen> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final _urnController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? _commencementDate;
  DateTime? _dueDate;
  User? _assignedTo;
  User? _assignedBy;

  Survey? _survey;

  void _populateFields(Survey survey) {
    _survey = survey;
    _urnController.text = survey.urn;
    _nameController.text = survey.name;
    _descriptionController.text = survey.description;
    _commencementDate = survey.commencementDate;
    _dueDate = survey.dueDate;
    _assignedTo = survey.assignedTo;
    _assignedBy = survey.assignedBy;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              EditSurveyCubit(context.read<SurveyRepository>())
                ..fetchSurveyById(widget.surveyId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Survey"),
          actions: const [UserButton()],
        ),
        body: BlocConsumer<EditSurveyCubit, EditSurveyState>(
          listener: (context, state) {
            if (state is EditSurveyFailure) {
              SnackbarUtils.showErrorSnackbar(context, message: state.message);
            } else if (state is EditSurveySuccess) {
              SnackbarUtils.showSuccessSnackbar(
                context,
                message: "Survey updated successfully",
              );
              context.pop();
            } else if (state is EditSurveyLoaded) {
              _populateFields(state.survey);
            }
          },
          builder: (context, state) {
            if (state is EditSurveyLoading || _survey == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return ScreenPadding(
              child: Form(
                key: _formKey,
                autovalidateMode: _autovalidateMode,
                child: ListView(
                  children: [
                    Vspace(24),
                    TextFormField(
                      controller: _urnController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: "URN",
                        helperText: "",
                      ),
                    ),
                    TextFormField(
                      controller: _nameController,
                      validator: SurveyFormValidations.validateName,
                      decoration: const InputDecoration(
                        labelText: "Survey Name",
                        helperText: "",
                      ),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: 40,
                        maxHeight: 180,
                      ),
                      child: TextFormField(
                        controller: _descriptionController,
                        validator: SurveyFormValidations.validateDescription,
                        maxLines: null,
                        decoration: const InputDecoration(
                          labelText: "Description",
                          helperText: "",
                        ),
                      ),
                    ),
                    UserDropdownButton(
                      label: "Assigned To",
                      validator:
                          (us) =>
                              SurveyFormValidations.validateAssignedTo(us?.id),
                      initialSelectedUser: _assignedTo,
                      fetchUsers:
                          context.read<AuthenticationRepository>().getAllUsers,
                      onChanged: (user) => _assignedTo = user,
                    ),
                    Vspace(12),
                    UserDropdownButton(
                      label: "Assigned By",
                      enabled: false,
                      initialSelectedUser: _assignedBy,
                      fetchUsers:
                          context.read<AuthenticationRepository>().getAllUsers,
                      onChanged: (user) => _assignedBy = user,
                    ),
                    Vspace(12),
                    InlineDateInput(
                      initialDate: _commencementDate,
                      validator: SurveyFormValidations.validateDate,
                      onDateSelected: (d) => _commencementDate = d,
                      label: "Commencement Date",
                    ),
                    InlineDateInput(
                      initialDate: _dueDate,
                      validator:
                          (d) =>
                              SurveyFormValidations.validateDueDateAfterStart(
                                _commencementDate,
                                d,
                              ),
                      onDateSelected: (d) => _dueDate = d,
                      label: "Due Date",
                    ),
                    Vspace(12),
                    PrimaryButton(
                      onPressed: () => _submit(context),
                      label: "Update Survey",
                    ),
                    Vspace(24),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    if (!(_formKey.currentState?.validate() ?? false)) {
      setState(() {
        _autovalidateMode = AutovalidateMode.onUserInteraction;
      });
      return;
    }

    context.read<EditSurveyCubit>().updateSurvey(
      surveyId: widget.surveyId,
      urn: _urnController.text,
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      startDate: _commencementDate!,
      dueDate: _dueDate!,
      assignedTo: _assignedTo!,
      assignedBy: _assignedBy!,
    );
  }
}
