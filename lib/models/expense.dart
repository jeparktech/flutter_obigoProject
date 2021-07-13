class Expense {
  int? amount;
  String? category;

  Expense(String type, int amount) {
    this.category = type;
    this.amount = amount;
  }
}
