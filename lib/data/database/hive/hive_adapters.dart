import 'package:hive_ce/hive.dart';
import 'package:school_surveys/domain/entities/user.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([AdapterSpec<User>()])
// This is for code generation
// ignore: unused_element
void _() {}
