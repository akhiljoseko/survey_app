import 'package:equatable/equatable.dart';

class SchoolType extends Equatable {
  final String label;
  final String value;

  const SchoolType(this.label, this.value);

  static const public = SchoolType('Public', 'public');
  static const private = SchoolType('Private', 'private');
  static const aided = SchoolType('Aided', 'aided');
  static const special = SchoolType('Special', 'special');

  static List<SchoolType> get values => [public, private, aided, special];

  @override
  List<Object?> get props => [value];

  @override
  String toString() => label;
}
