import 'package:hive_ce/hive.dart';
import 'package:school_surveys/domain/entities/school_data.dart';
import 'package:school_surveys/domain/entities/survey.dart';
import 'package:school_surveys/domain/entities/survey_general_data.dart';
import 'package:school_surveys/domain/entities/user.dart';
import 'package:school_surveys/domain/constants/curriculum.dart';
import 'package:school_surveys/domain/constants/grade_level.dart';
import 'package:school_surveys/domain/constants/school_type.dart';
import 'package:school_surveys/domain/enums/survey_status.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<User>(),
  AdapterSpec<Survey>(),
  AdapterSpec<SurveyGeneralData>(),
  AdapterSpec<SchoolData>(),

  AdapterSpec<SurveyStatus>(),
  AdapterSpec<Curriculum>(),
  AdapterSpec<GradeLevel>(),
  AdapterSpec<SchoolType>(),
])
// This is for code generation
// ignore: unused_element
void _() {}
