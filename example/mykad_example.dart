// ignore_for_file: avoid_print

import 'package:mykad/mykad.dart';

void main() {
  final mykad = MyKad.parse('980927120123', referenceDate: DateTime(2023));
  print(mykad.formattedNric); // 980927-12-0123
  print(mykad.gender); // Gender.male
  print(mykad.birthdate); // DateTime(1998, 09, 27)
  print(mykad.age); // 25
}
