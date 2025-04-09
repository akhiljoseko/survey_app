import 'package:school_surveys/core/app_exception.dart';

class SurveyUrnGenerationException extends AppException {
  SurveyUrnGenerationException({
    super.code = 2000,
    super.message =
        "Failed to generate unique URN after 10 attempts. Please try again after 10 seconds.",
  });
}
