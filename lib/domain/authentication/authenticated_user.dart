class AuthenticatedUser {
  final String uid;
  final String email;
  final String displayName;
  final String? phoneNumber;
  final String? photoURL;

  const AuthenticatedUser({
    required this.uid,
    required this.email,
    required this.displayName,
    this.phoneNumber,
    this.photoURL,
  });
}
