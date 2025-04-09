import 'package:equatable/equatable.dart';

abstract class BaseEntity extends Equatable {
  final String id;
  final DateTime createdAt;

  const BaseEntity({required this.id, required this.createdAt});
}
