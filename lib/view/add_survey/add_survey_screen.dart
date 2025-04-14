import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:school_surveys/domain/entities/user.dart';
import 'package:school_surveys/domain/repository/authentication_repository.dart';
import 'package:school_surveys/domain/repository/survey_repository.dart';
import 'package:school_surveys/utils/loading_indicator.dart';
import 'package:school_surveys/utils/snackbar_utils.dart';
import 'package:school_surveys/view/add_survey/cubit/add_survey_cubit.dart';
import 'package:school_surveys/view/add_survey/survey_from_validations.dart';
import 'package:school_surveys/view/authentication/auth_cubit.dart';
import 'package:school_surveys/view/widgets/user_button.dart';
import 'package:school_surveys/view/widgets/inline_date_input_field.dart';
import 'package:school_surveys/view/widgets/primary_button.dart';
import 'package:school_surveys/view/widgets/spacing.dart';
import 'package:school_surveys/view/widgets/user_drop_down_button.dart';

class AddSurveyScreen extends StatefulWidget {
  const AddSurveyScreen({super.key});

  @override
  State<AddSurveyScreen> createState() => _AddSurveyScreenState();
}

class _AddSurveyScreenState extends State<AddSurveyScreen> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final _urnController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? commencementDate;
  DateTime? _dueDate;

  User? _assignedTo;
  User? _assignedBy;

  @override
  Widget build(BuildContext context) {
    _assignedBy = context.read<AuthCubit>().state.user!;
    return BlocProvider(
      create: (context) => AddSurveyCubit(context.read<SurveyRepository>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Survey"),
          actions: [UserButton()],
        ),
        body: ScreenPadding(
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: ListView(
              children: [
                Vspace(24),
                TextFormField(
                  controller: _urnController,
                  readOnly: true,
                  canRequestFocus: false,
                  decoration: const InputDecoration(
                    helperText: "",
                    labelText: "Unique Reference Number (URN)",
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
                  constraints: BoxConstraints(minHeight: 40, maxHeight: 180),
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
                      (us) => SurveyFormValidations.validateAssignedTo(us?.id),
                  initialSelectedUser: _assignedTo,
                  fetchUsers:
                      context.read<AuthenticationRepository>().getAllUsers,
                  onChanged: (userId) => _assignedTo = userId,
                ),
                Vspace(12),
                UserDropdownButton(
                  label: "Assigned By",
                  enabled: false,
                  initialSelectedUser: _assignedBy,
                  fetchUsers:
                      context.read<AuthenticationRepository>().getAllUsers,
                  onChanged: (userId) => _assignedBy = userId,
                ),
                Vspace(12),
                InlineDateInput(
                  initialDate: commencementDate,
                  validator: SurveyFormValidations.validateDate,
                  onDateSelected: (d) => commencementDate = d,
                  label: "Commencement Date",
                ),
                InlineDateInput(
                  initialDate: _dueDate,
                  validator:
                      (dueDate) =>
                          SurveyFormValidations.validateDueDateAfterStart(
                            commencementDate,
                            dueDate,
                          ),
                  onDateSelected: (d) => _dueDate = d,
                  label: "Due Date",
                ),
                Vspace(12),
                BlocConsumer<AddSurveyCubit, AddSurveyState>(
                  listener: (context, state) {
                    if (state is AddSurveyLoading) {
                      LoadingIndicator.showLoading(context);
                      return;
                    }
                    LoadingIndicator.removeLoading(context);
                    if (state is AddSurveyUrnGenerated) {
                      _urnController.text = state.urn;
                    }

                    if (state is AddSurveyFailure) {
                      SnackbarUtils.showErrorSnackbar(
                        context,
                        message: state.message,
                      );
                    }
                    if (state is AddSurveySuccess) {
                      SnackbarUtils.showSuccessSnackbar(
                        context,
                        message: "Survey created successfully",
                      );
                      context.pop();
                    }
                  },
                  builder:
                      (context, _) => PrimaryButton(
                        onPressed: () => _submitSurvey(context),
                        label: "Create Survey",
                      ),
                ),
                Vspace(24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitSurvey(BuildContext context) {
    final currentUser = context.read<AuthCubit>().state.user!;

    if (!(_formKey.currentState?.validate() ?? false)) {
      setState(() {
        _autovalidateMode = AutovalidateMode.onUserInteraction;
      });
      return;
    }
    context.read<AddSurveyCubit>().submitSurvey(
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      startDate: commencementDate!,
      dueDate: _dueDate!,
      assignedTo: _assignedTo!,
      assignedBy: currentUser,
      createdBy: currentUser.id,
    );
  }
}
