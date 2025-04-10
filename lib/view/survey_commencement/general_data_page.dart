import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_surveys/view/survey_commencement/cubit/commencement_progress/commencement_progress_cubit.dart';
import 'package:school_surveys/view/survey_commencement/cubit/general_data/general_data_cubit.dart';
import 'package:school_surveys/view/widgets/spacing.dart';

class GeneralDataPage extends StatefulWidget {
  const GeneralDataPage({super.key});

  @override
  State<GeneralDataPage> createState() => _GeneralDataPageState();
}

class _GeneralDataPageState extends State<GeneralDataPage> {
  late final TextEditingController _areaController = TextEditingController();
  int? _selectedSchoolCount;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = context.watch<GeneralDataCubit>().state;
    if (state is GeneralDataLoaded) {
      _areaController.text = state.data.areaName;
      _selectedSchoolCount = state.data.numberOfSchools;
    }
  }

  @override
  void dispose() {
    _areaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScreenPadding(
        child: BlocBuilder<GeneralDataCubit, GeneralDataState>(
          builder: (context, state) {
            return Column(
              children: [
                TextFormField(
                  controller: _areaController,
                  decoration: const InputDecoration(labelText: "Area Name"),
                ),
                const Vspace(16),
                DropdownButtonFormField<int>(
                  value: _selectedSchoolCount,
                  decoration: const InputDecoration(
                    labelText: "Number of Schools",
                  ),
                  items: List.generate(
                    5,
                    (index) => DropdownMenuItem(
                      value: index + 1,
                      child: Text("${index + 1}"),
                    ),
                  ),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedSchoolCount = value;
                      });
                    }
                  },
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    context.read<GeneralDataCubit>().save(
                      _areaController.text.trim(),
                      _selectedSchoolCount ?? 1,
                    );
                    context.read<CommencementProgressCubit>().updateTotalSteps(
                      (_selectedSchoolCount ?? 1) + 1,
                    );
                    context.read<CommencementProgressCubit>().next();
                  },
                  child: const Text("Next"),
                ),
                const Vspace(24),
              ],
            );
          },
        ),
      ),
    );
  }
}
