import 'package:hive_flutter/hive_flutter.dart';
part 'key_and_company.g.dart';

@HiveType(typeId: 0)
class KeyAndCompany {
  @HiveField(0)
  final String keyGptName;
  @HiveField(1)
  final String anyCompany;

  KeyAndCompany(
      {required this.keyGptName, required this.anyCompany}
      );
}