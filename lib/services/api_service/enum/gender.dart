enum Gender {
  male(value: 'MALE'),
  female(value: 'FAMALE');

  final String value;

  const Gender({
    required this.value,
  });

  static Gender parse({required int gender}) {
    switch (gender) {
      case 1:
      case 3:
        return Gender.male;
      case 2:
      case 4:
        return Gender.female;
      default:
        throw Exception('[Gender.parse] invalid gender value: $gender');
    }
  }
}
