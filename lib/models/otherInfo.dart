enum InfoType {
  parkingInfo,
  carWashInfo,
  repairInfo,
}

class OtherInformation {
  String id = DateTime.now().toString();
  String? date;
  int? totalPrice;
  int? cm; //cumulative mileage - 누적 주행거리
  String? memo;
  InfoType? infoType;

  OtherInformation({
    required this.date,
    required this.totalPrice,
    required this.cm,
    required this.infoType,
    this.memo,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'totalPrice': totalPrice,
      'cm': cm,
      'infoType': infoTypeText,
      'memo': memo,
    };
  }

  String get infoTypeText {
    switch (infoType) {
      case InfoType.carWashInfo:
        return 'carWashInfo';
      case InfoType.parkingInfo:
        return 'parkingInfo';
      case InfoType.repairInfo:
        return 'repairInfo';
      default:
        return 'unknown';
    }
  }

  @override
  String toString() {
    return '종류: $infoType\n날짜: $date\n총액: $totalPrice\n누적 주행거리: $cm\n메모: $memo\n';
  }
}
