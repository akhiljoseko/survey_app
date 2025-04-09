import 'package:school_surveys/domain/entities/base_entity.dart';

class User extends BaseEntity {
  final String email;
  final String password;
  final String displayName;
  final String? photoURL;

  const User({
    required super.id,
    required super.createdAt,
    required this.email,
    required this.password,
    required this.displayName,
    this.photoURL,
  });

  @override
  List<Object?> get props => [id, email];
}
