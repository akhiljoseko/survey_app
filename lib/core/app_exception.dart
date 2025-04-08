abstract class AppException implements Exception {
  final int code;
  final String message;

  AppException({required this.code, required this.message});
}

class UnknownException extends AppException {
  UnknownException({
    super.code = 10000,
    super.message = "An unknown error occured. Please try again",
  });
}
