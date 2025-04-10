import 'package:school_surveys/core/app_exception.dart';

class RecordNotFoundException extends AppException {
  RecordNotFoundException({
    super.code = 900,
    super.message = "The record with given id is not found",
  });
}
