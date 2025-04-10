// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[4] as String,
      createdAt: fields[5] as DateTime,
      email: fields[0] as String,
      password: fields[1] as String,
      displayName: fields[2] as String,
      photoURL: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.displayName)
      ..writeByte(3)
      ..write(obj.photoURL)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SurveyAdapter extends TypeAdapter<Survey> {
  @override
  final int typeId = 1;

  @override
  Survey read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Survey(
      id: fields[9] as String,
      createdAt: fields[10] as DateTime,
      urn: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      commencementDate: fields[3] as DateTime,
      dueDate: fields[4] as DateTime,
      assignedTo: fields[5] as String,
      assignedBy: fields[6] as String,
      createdBy: fields[7] as String,
      status: fields[8] as SurveyStatus,
    );
  }

  @override
  void write(BinaryWriter writer, Survey obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.urn)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.commencementDate)
      ..writeByte(4)
      ..write(obj.dueDate)
      ..writeByte(5)
      ..write(obj.assignedTo)
      ..writeByte(6)
      ..write(obj.assignedBy)
      ..writeByte(7)
      ..write(obj.createdBy)
      ..writeByte(8)
      ..write(obj.status)
      ..writeByte(9)
      ..write(obj.id)
      ..writeByte(10)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurveyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SurveyStatusAdapter extends TypeAdapter<SurveyStatus> {
  @override
  final int typeId = 2;

  @override
  SurveyStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SurveyStatus.scheduled;
      case 1:
        return SurveyStatus.completed;
      case 2:
        return SurveyStatus.withheld;
      default:
        return SurveyStatus.scheduled;
    }
  }

  @override
  void write(BinaryWriter writer, SurveyStatus obj) {
    switch (obj) {
      case SurveyStatus.scheduled:
        writer.writeByte(0);
      case SurveyStatus.completed:
        writer.writeByte(1);
      case SurveyStatus.withheld:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurveyStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SurveyGeneralDataAdapter extends TypeAdapter<SurveyGeneralData> {
  @override
  final int typeId = 3;

  @override
  SurveyGeneralData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SurveyGeneralData(
      id: fields[2] as String,
      createdAt: fields[3] as DateTime,
      areaName: fields[0] as String,
      numberOfSchools: (fields[1] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, SurveyGeneralData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.areaName)
      ..writeByte(1)
      ..write(obj.numberOfSchools)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurveyGeneralDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SchoolDataAdapter extends TypeAdapter<SchoolData> {
  @override
  final int typeId = 4;

  @override
  SchoolData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SchoolData(
      id: fields[7] as String,
      createdAt: fields[8] as DateTime,
      surveyId: fields[0] as String,
      schoolNumber: (fields[1] as num).toInt(),
      schoolName: fields[2] as String,
      schoolType: fields[3] as SchoolType,
      curriculum: (fields[4] as List).cast<Curriculum>(),
      establishedOn: fields[5] as DateTime,
      gradesPresent: (fields[6] as List).cast<GradeLevel>(),
    );
  }

  @override
  void write(BinaryWriter writer, SchoolData obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.surveyId)
      ..writeByte(1)
      ..write(obj.schoolNumber)
      ..writeByte(2)
      ..write(obj.schoolName)
      ..writeByte(3)
      ..write(obj.schoolType)
      ..writeByte(4)
      ..write(obj.curriculum)
      ..writeByte(5)
      ..write(obj.establishedOn)
      ..writeByte(6)
      ..write(obj.gradesPresent)
      ..writeByte(7)
      ..write(obj.id)
      ..writeByte(8)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SchoolDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CurriculumAdapter extends TypeAdapter<Curriculum> {
  @override
  final int typeId = 5;

  @override
  Curriculum read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Curriculum(fields[4] as String, fields[5] as String);
  }

  @override
  void write(BinaryWriter writer, Curriculum obj) {
    writer
      ..writeByte(2)
      ..writeByte(4)
      ..write(obj.label)
      ..writeByte(5)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurriculumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GradeLevelAdapter extends TypeAdapter<GradeLevel> {
  @override
  final int typeId = 6;

  @override
  GradeLevel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GradeLevel(fields[3] as String, fields[4] as String);
  }

  @override
  void write(BinaryWriter writer, GradeLevel obj) {
    writer
      ..writeByte(2)
      ..writeByte(3)
      ..write(obj.label)
      ..writeByte(4)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GradeLevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SchoolTypeAdapter extends TypeAdapter<SchoolType> {
  @override
  final int typeId = 7;

  @override
  SchoolType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SchoolType(fields[4] as String, fields[5] as String);
  }

  @override
  void write(BinaryWriter writer, SchoolType obj) {
    writer
      ..writeByte(2)
      ..writeByte(4)
      ..write(obj.label)
      ..writeByte(5)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SchoolTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
