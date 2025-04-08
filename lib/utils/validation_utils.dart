class ValidationUtils {
  static const int minPasswordLength = 8;

  /// Validates an email address
  /// Returns null if valid, error message if invalid
  static String? validateEmail(String? email) {
    email = email?.trim();
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegExp.hasMatch(email)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  /// Validates a password
  /// Returns null if valid, error message if invalid
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    if (password.length < minPasswordLength) {
      return 'Password must be at least $minPasswordLength characters long';
    }

    // // Check for at least one uppercase letter
    // if (!password.contains(RegExp(r'[A-Z]'))) {
    //   return 'Password must contain at least one uppercase letter';
    // }

    // // Check for at least one lowercase letter
    // if (!password.contains(RegExp(r'[a-z]'))) {
    //   return 'Password must contain at least one lowercase letter';
    // }

    // // Check for at least one number
    // if (!password.contains(RegExp(r'[0-9]'))) {
    //   return 'Password must contain at least one number';
    // }

    // // Check for at least one special character
    // if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    //   return 'Password must contain at least one special character';
    // }

    return null;
  }

  /// Validates password confirmation
  /// Returns null if valid, error message if invalid
  static String? validatePasswordConfirmation(
    String? password,
    String? confirmPassword,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }

  /// Check password strength and return a score from 0 to 4
  static int getPasswordStrength(String password) {
    int score = 0;

    if (password.length >= minPasswordLength) score++;
    if (password.contains(RegExp(r'[A-Z]'))) score++;
    if (password.contains(RegExp(r'[0-9]'))) score++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) score++;

    return score;
  }

  /// Get a description of password strength
  static String getPasswordStrengthText(int strength) {
    switch (strength) {
      case 0:
        return 'Very Weak';
      case 1:
        return 'Weak';
      case 2:
        return 'Medium';
      case 3:
        return 'Strong';
      case 4:
        return 'Very Strong';
      default:
        return 'Invalid';
    }
  }

  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Please enter your name.';
    }
    return null;
  }
}
