import 'package:school_surveys/domain/constants/curriculum.dart';
import 'package:school_surveys/domain/constants/grade_level.dart';

class SchoolDataFormValidations {
  static String? validateName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return 'School name is required';
    }
    if (name.trim().length < 3) {
      return 'School name must be at least 3 characters';
    }
    return null;
  }

  static String? validateType(dynamic type) {
    if (type == null) {
      return 'Please select the type of school';
    }
    return null;
  }

  static String? validateEstablishedOn(DateTime? date) {
    if (date == null) {
      return 'Please select the established date';
    }
    if (date.isAfter(DateTime.now())) {
      return 'Established date cannot be in the future';
    }
    return null;
  }

  static String? validateCurriculum(List<Curriculum>? curriculum) {
    if (curriculum?.isEmpty ?? true) {
      return 'Please select at least one curriculum';
    }
    return null;
  }

  static String? validateGrades(List<GradeLevel>? grades) {
    if (grades?.isEmpty ?? true) {
      return 'Please select at least one grade level';
    }
    return null;
  }
}
