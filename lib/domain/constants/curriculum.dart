import 'package:equatable/equatable.dart';

class Curriculum extends Equatable {
  final String label;
  final String value;

  const Curriculum(this.label, this.value);

  static const cbse = Curriculum('CBSE', 'cbse');
  static const icse = Curriculum('ICSE', 'icse');
  static const ib = Curriculum('IB', 'ib');
  static const state = Curriculum('State board', 'state');

  static List<Curriculum> get values => [cbse, icse, ib, state];

  @override
  List<Object?> get props => [value];

  @override
  String toString() => label;
}
