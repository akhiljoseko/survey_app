import 'package:school_surveys/domain/entities/base_entity.dart';

class SurveyGeneralData extends BaseEntity {
  final String areaName;
  final int numberOfSchools;

  const SurveyGeneralData({
    required super.id,
    required super.createdAt,
    required this.areaName,
    required this.numberOfSchools,
  });

  @override
  List<Object?> get props => [id, createdAt, areaName, numberOfSchools];
}
