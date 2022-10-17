enum Gender {
  male(value: 'MALE'),
  female(value: 'FAMALE');

  final String value;

  const Gender({
    required this.value,
  });

  static Gender parse({required int gender}) {
    gender = gender % 2;

    if (gender == 0) {
      return Gender.female;
    }

    if (gender == 1) {
      return Gender.male;
    }

    throw Exception('[Gender.parse] invalid gender value: $gender');
  }
}
