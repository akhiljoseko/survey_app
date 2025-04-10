import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_surveys/domain/constants/curriculum.dart';
import 'package:school_surveys/domain/constants/grade_level.dart';
import 'package:school_surveys/domain/constants/school_type.dart';
import 'package:school_surveys/view/survey_commencement/cubit/school_data/school_data_cubit.dart';
import 'package:school_surveys/view/survey_commencement/school_data_form_validations.dart';
import 'package:school_surveys/view/survey_commencement/widgets/multi_select_chip_form_field.dart';
import 'package:school_surveys/view/widgets/inline_date_input_field.dart';
import 'package:school_surveys/view/widgets/spacing.dart';

class SchoolDataPage extends StatefulWidget {
  final int index;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final bool isLast;

  const SchoolDataPage({
    super.key,
    required this.index,
    required this.onBack,
    required this.onNext,
    required this.isLast,
  });

  @override
  State<SchoolDataPage> createState() => _SchoolDataPageState();
}

class _SchoolDataPageState extends State<SchoolDataPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final _nameController = TextEditingController();
  SchoolType _selectedType = SchoolType.public;
  DateTime? _establishedOn;
  final List<Curriculum> _selectedCurricula = [];
  final List<GradeLevel> _selectedGrades = [];

  @override
  void initState() {
    super.initState();
    _prepopulateIfAvailable();
  }

  void _prepopulateIfAvailable() {
    final cubit = context.read<SchoolDataCubit>();
    final existingSchool = cubit.getSchoolData(widget.index);

    if (existingSchool != null) {
      _nameController.text = existingSchool.schoolName;
      _selectedType = existingSchool.schoolType;
      _establishedOn = existingSchool.establishedOn;
      _selectedCurricula.addAll(existingSchool.curriculum);
      _selectedGrades.addAll(existingSchool.gradesPresent);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: ListView(
          children: [
            Text(
              "School - ${widget.index}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Vspace(16),

            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Name of the School",
              ),
              validator: SchoolDataFormValidations.validateName,
            ),
            const Vspace(16),

            InlineDateInput(
              initialDate: _establishedOn,
              onDateSelected: (s) => _establishedOn = s,
              label: "Established On",
              enabledDateRangeStart: DateTime(1800),
              enabledDateRangeEnd: DateTime.now(),
              validator: SchoolDataFormValidations.validateEstablishedOn,
            ),

            const Vspace(16),
            DropdownButtonFormField<SchoolType>(
              value: _selectedType,
              decoration: const InputDecoration(
                labelText: "Type of the School",
              ),
              items:
                  SchoolType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type.label),
                    );
                  }).toList(),
              onChanged: (value) {
                if (value != null) setState(() => _selectedType = value);
              },
              validator: SchoolDataFormValidations.validateType,
            ),
            const Vspace(16),

            MultiSelectChipFormField(
              labelText: "Curriculum",
              options: Curriculum.values,
              labelTextForOption: (c) => c.label,
              initialValue: _selectedCurricula,
              onChanged: (cr) {
                _selectedCurricula
                  ..clear()
                  ..addAll(cr);
              },
              validator: SchoolDataFormValidations.validateCurriculum,
            ),

            MultiSelectChipFormField(
              labelText: "Grades Present",
              options: GradeLevel.values,
              labelTextForOption: (c) => c.label,
              initialValue: _selectedGrades,
              onChanged: (gr) {
                _selectedGrades
                  ..clear()
                  ..addAll(gr);
              },
              validator: SchoolDataFormValidations.validateGrades,
            ),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.onBack,
                    child: const Text("Back"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _handleNext(context),
                    child: Text(widget.isLast ? "Finish" : "Next"),
                  ),
                ),
              ],
            ),
            Vspace(24),
          ],
        ),
      ),
    );
  }

  Future<void> _handleNext(BuildContext context) async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      setState(() {
        _autovalidateMode = AutovalidateMode.onUserInteraction;
      });
      return;
    }

    // Save the current school data to the cubit and to the storage
    await context.read<SchoolDataCubit>().saveSchool(
      schoolNumber: widget.index,
      schoolName: _nameController.text.trim(),
      schoolType: _selectedType,
      curriculum: _selectedCurricula,
      establishedOn: _establishedOn!,
      gradesPresents: _selectedGrades,
    );

    widget.onNext();
  }
}
