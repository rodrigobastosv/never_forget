class Configurations {
  int languageId;
  int hoursToNotificate;
  bool darkMode;

  Configurations fromJson(Map<String, dynamic> map) {
    return Configurations()
      ..languageId = map['languageId']
      ..hoursToNotificate = map['hoursToNotificate']
      ..darkMode = map['darkMode'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'languageId': languageId,
      'hoursToNotificate': hoursToNotificate,
      'darkMode': darkMode,
    };
  }

  @override
  String toString() {
    return 'Configurations{languageId: $languageId, hoursToNotificate: $hoursToNotificate, darkMode: $darkMode}';
  }
}