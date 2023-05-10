Parses Malaysian Identification Card numbers (MyKad).

## Installing

Add the following line to your `pubspec.yaml` file.

```yaml
mykad: ^0.0.1
```

## Example

```dart
final mykad = MyKad.parse(
    '980927120123',
    referenceDate: DateTime(2023), // optional
);
print(mykad.formattedNric); // 980927-12-0123
print(mykad.gender); // Gender.male
print(mykad.birthdate); // DateTime(1998, 09, 27)
print(mykad.age); // 25
```
