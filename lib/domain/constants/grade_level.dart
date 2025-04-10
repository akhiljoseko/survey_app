import 'package:equatable/equatable.dart';

class GradeLevel extends Equatable {
  final String label;
  final String value;

  const GradeLevel(this.label, this.value);

  static const primary = GradeLevel('Primary', 'primary');
  static const secondary = GradeLevel('Secondary', 'secondary');
  static const higherSecondary = GradeLevel(
    'Higher Secondary',
    'higherSecondary',
  );

  static List<GradeLevel> get values => [primary, secondary, higherSecondary];

  @override
  List<Object?> get props => [value];

  @override
  String toString() => label;
}
