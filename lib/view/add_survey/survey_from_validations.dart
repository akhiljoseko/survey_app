class SurveyFormValidations {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Survey name is required';
    }
    if (value.trim().length < 3) {
      return 'Survey name must be at least 3 characters';
    }
    return null;
  }

  static String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Description is required';
    }
    return null;
  }

  static String? validateAssignedTo(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Assigned To is required';
    }
    return null;
  }

  static String? validateDate(DateTime? date, {String label = 'Date'}) {
    if (date == null) {
      return '$label is required';
    }
    return null;
  }

  static String? validateDueDateAfterStart(
    DateTime? startDate,
    DateTime? dueDate,
  ) {
    if (dueDate == null) {
      return "Please select a due date for survey";
    }
    if (startDate == null) {
      return null;
    }
    if (dueDate.isBefore(startDate)) {
      return 'Due date must be after commencement date';
    }

    return null;
  }
}
