import 'package:school_surveys/core/app_exception.dart';

class InvalidCredentialsException extends AppException {
  InvalidCredentialsException({
    super.code = 1000,
    super.message =
        "Email or password is incorrect. Please check your credentials and try again.",
  });
}
