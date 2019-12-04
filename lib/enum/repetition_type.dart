import 'package:hive/hive.dart';

part 'repetition_type.g.dart';

@HiveType()
enum RepetitionType {
  @HiveField(0)
  onetimeOnly,

  @HiveField(1)
  daily,

  @HiveField(2)
  monthly,

  @HiveField(3)
  yearly,
}