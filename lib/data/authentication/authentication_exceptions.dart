import 'package:school_surveys/core/app_exception.dart';

class InvalidCredentialsException extends AppException {
  InvalidCredentialsException({
    super.code = 1000,
    super.message =
        "Email or password is incorrect. Please check your credentials and try again.",
  });
}

class AccountNotFound extends AppException {
  AccountNotFound({
    super.code = 1001,
    super.message =
        "We coudn't find an account with this email. Please check your email and try again.",
  });
}

class AccountExists extends AppException {
  AccountExists({
    super.code = 1002,
    super.message =
        "An account with this email already exists. Please use a different email to create an account.",
  });
}
