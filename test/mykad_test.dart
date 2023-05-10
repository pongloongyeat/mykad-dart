import 'package:mykad/src/mykad.dart';
import 'package:test/test.dart';

void main() {
  group('MyKad', () {
    final referenceDate = DateTime(2023, 5, 10);

    final validMyKadsWithDashes = [
      MyKadTestHelper(
        nric: '691206-10-5330',
        gender: Gender.female,
        birthdate: DateTime(1969, 12, 6),
        age: referenceDate.year - 1969,
      ),
      MyKadTestHelper(
        nric: '860306-05-5878',
        gender: Gender.female,
        birthdate: DateTime(1986, 3, 6),
        age: referenceDate.year - 1986,
      ),
      MyKadTestHelper(
        nric: '460619-12-5087',
        gender: Gender.male,
        birthdate: DateTime(1946, 6, 19),
        age: referenceDate.year - 1946,
      ),
      MyKadTestHelper(
        nric: '800220-04-5063',
        gender: Gender.male,
        birthdate: DateTime(1980, 2, 20),
        age: referenceDate.year - 1980,
      ),
      MyKadTestHelper(
        nric: '011112-01-5901',
        gender: Gender.male,
        birthdate: DateTime(2001, 11, 12),
        age: referenceDate.year - 2001,
      ),
      MyKadTestHelper(
        nric: '110824-14-3742',
        gender: Gender.female,
        birthdate: DateTime(2011, 8, 24),
        age: referenceDate.year - 2011,
      ),
    ];
    final validMyKadsWithoutDashes = validMyKadsWithDashes
        .map((e) => e.copyWith(nric: e.nric.replaceAll('-', '')))
        .toList();

    test('parses valid MyKads', () {
      expect(
        validMyKadsWithDashes
            .map((e) => MyKad.tryParse(e.nric))
            .any((element) => element == null),
        false,
      );
    });

    test('parsed MyKads are the same with or without dashes', () {
      final myKads = validMyKadsWithDashes.map((e) => MyKad.parse(e.nric));
      final myKadsWithoutDashes =
          validMyKadsWithoutDashes.map((e) => MyKad.parse(e.nric));

      expect(
        myKads.map((e) => e.nric).toList(),
        myKadsWithoutDashes.map((e) => e.nric).toList(),
      );
      expect(
        myKads.map((e) => e.formattedNric).toList(),
        myKadsWithoutDashes.map((e) => e.formattedNric).toList(),
      );
      expect(
        myKads.map((e) => e.gender).toList(),
        myKadsWithoutDashes.map((e) => e.gender).toList(),
      );
      expect(
        myKads.map((e) => e.birthdate).toList(),
        myKadsWithoutDashes.map((e) => e.birthdate).toList(),
      );
      expect(
        myKads.map((e) => e.age).toList(),
        myKadsWithoutDashes.map((e) => e.age).toList(),
      );
    });

    test('parses birthdate correctly', () {
      expect(
        validMyKadsWithDashes
            .map((e) => MyKad.parse(e.nric).birthdate.isSameDayAs(e.birthdate))
            .all((e) => e == true),
        true,
      );
    });

    test('parses gender correctly', () {
      expect(
        validMyKadsWithDashes
            .map((e) => MyKad.parse(e.nric).gender == e.gender)
            .all((e) => e == true),
        true,
      );
    });
  });
}

extension on DateTime {
  bool isSameDayAs(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension IterableX<E> on Iterable<E> {
  /// Checks whether all elements of this iterable satisfies [test].
  ///
  /// Checks every element in iteration order, and returns `false` if
  /// any of them make [test] return `false`, otherwise returns true.
  ///
  /// Example:
  /// ```dart
  /// final numbers = <int>[1, 2, 3, 5, 6, 7];
  /// var result = numbers.all((element) => element >= 5); // false;
  /// result = numbers.all((element) => element <= 10); // true;
  /// ```
  bool all(bool Function(E e) test) {
    for (final element in this) {
      if (!test(element)) return false;
    }

    return true;
  }
}

class MyKadTestHelper {
  const MyKadTestHelper({
    required this.nric,
    required this.gender,
    required this.birthdate,
    required this.age,
  });

  final String nric;
  final Gender gender;
  final DateTime birthdate;
  final int age;

  MyKadTestHelper copyWith({String? nric}) {
    return MyKadTestHelper(
      nric: nric ?? this.nric,
      gender: gender,
      birthdate: birthdate,
      age: age,
    );
  }
}
