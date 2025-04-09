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
