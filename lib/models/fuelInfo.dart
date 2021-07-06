class FuelInformation {
  String date;
  String fuelType;
  int unitPrice;
  double quantity;
  int totalPrice;

  FuelInformation(
      {required this.date,
      required this.fuelType,
      required this.unitPrice,
      required this.quantity,
      required this.totalPrice});

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'fuelType': fuelType,
      'unitPrice': unitPrice,
      'quantity': quantity,
      'totalPrice': totalPrice
    };
  }

  @override
  String toString() {
    return '\n날짜: $date\n유종: $fuelType\n단가: $unitPrice\n수량: $quantity\n총액: $totalPrice\n';
  }
}
