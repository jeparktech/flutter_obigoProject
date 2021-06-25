class FuelInformation {
  final int date;
  final String fuelType;
  final int unitPrice;
  final int quantity;
  final int totalPrice;

  FuelInformation(
      {this.date,
      this.fuelType,
      this.unitPrice,
      this.quantity,
      this.totalPrice});

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
    return '주유 정보\n날짜: $date\n유종: $fuelType\n단가: $unitPrice\n수량: $quantity\n총액: $totalPrice';
  }
}
