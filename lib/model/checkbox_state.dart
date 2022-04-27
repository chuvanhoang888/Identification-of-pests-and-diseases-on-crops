class CheckboxState {
  final String title;
  String image;
  final int price;
  final int amount;
  bool value;

  CheckboxState({
    required this.title,
    required this.image,
    required this.price,
    required this.amount,
    this.value = false,
  });
}

class CheckboxAllState {
  final String title;
  final bool value;

  CheckboxAllState({
    required this.title,
    this.value = false,
  });
}
