import 'package:school_surveys/domain/entities/base_entity.dart';
import 'package:school_surveys/domain/constants/curriculum.dart';
import 'package:school_surveys/domain/constants/grade_level.dart';
import 'package:school_surveys/domain/constants/school_type.dart';

class SchoolData extends BaseEntity {
  final String surveyId;
  final int schoolNumber;
  final String schoolName;
  final SchoolType schoolType; // Enum
  final List<Curriculum> curriculum;
  final DateTime establishedOn;
  final List<GradeLevel> gradesPresent;

  const SchoolData({
    required super.id,
    required super.createdAt,
    required this.surveyId,
    required this.schoolNumber,
    required this.schoolName,
    required this.schoolType,
    required this.curriculum,
    required this.establishedOn,
    required this.gradesPresent,
  });

  @override
  List<Object?> get props => [id, surveyId, createdAt];
}
