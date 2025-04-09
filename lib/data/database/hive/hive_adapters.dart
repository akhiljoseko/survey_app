import 'package:hive_ce/hive.dart';
import 'package:school_surveys/domain/entities/survey.dart';
import 'package:school_surveys/domain/entities/user.dart';
import 'package:school_surveys/domain/enums/survey_status.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<User>(),
  AdapterSpec<Survey>(),
  AdapterSpec<SurveyStatus>(),
])
// This is for code generation
// ignore: unused_element
void _() {}
