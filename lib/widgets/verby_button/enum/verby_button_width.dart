enum VerbyButtonWidth {
  expand(value: double.infinity),
  contract(value: null);

  final double? value;

  const VerbyButtonWidth({required this.value});
}
