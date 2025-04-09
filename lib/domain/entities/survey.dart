import 'package:school_surveys/domain/entities/base_entity.dart';
import 'package:school_surveys/domain/enums/survey_status.dart';

class Survey extends BaseEntity {
  final String urn;
  final String name;
  final String description;
  final DateTime commencementDate;
  final DateTime dueDate;
  final String assignedTo;
  final String assignedBy;
  final String createdBy;
  final SurveyStatus status;

  const Survey({
    required super.id,
    required super.createdAt,
    required this.urn,
    required this.name,
    required this.description,
    required this.commencementDate,
    required this.dueDate,
    required this.assignedTo,
    required this.assignedBy,
    required this.createdBy,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    createdAt,
    urn,
    name,
    description,
    commencementDate,
    dueDate,
    assignedTo,
    assignedBy,
    status,
  ];
}
