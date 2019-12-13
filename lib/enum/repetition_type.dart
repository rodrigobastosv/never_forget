import 'package:hive/hive.dart';

part 'repetition_type.g.dart';

@HiveType()
enum RepetitionType {
  @HiveField(0)
  onetimeOnly,

  @HiveField(1)
  daily,

  @HiveField(2)
  weekly,
}

List<String> getAllRepetiton() {
  return [
    getRepetitonString(RepetitionType.onetimeOnly),
    getRepetitonString(RepetitionType.daily),
    getRepetitonString(RepetitionType.weekly),
  ];
}

RepetitionType getRepetiton(String repetitionType) {
  switch (repetitionType) {
    case 'Sem Repetição':
      return RepetitionType.onetimeOnly;
    case 'Diária':
      return RepetitionType.daily;
    case 'Semanal':
      return RepetitionType.weekly;
  }
  return RepetitionType.onetimeOnly;
}

String getRepetitonString(RepetitionType repetitionType) {
  switch (repetitionType) {
    case RepetitionType.onetimeOnly:
      return 'Sem Repetição';
    case RepetitionType.daily:
      return 'Diária';
    case RepetitionType.weekly:
      return 'Semanal';
  }
  return 'Sem Repetição';
}