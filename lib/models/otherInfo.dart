enum InfoType {
  parkingInfo,
  carWashInfo,
  repairInfo,
}

class OtherInformation {
  String? date;
  int? totalAmount;
  int? cm; //cumulative mileage - 누적 주행거리
  String? memo;
  InfoType? infoType;

  OtherInformation({
    required date,
    required totalAmount,
    required cm,
    required infoType,
    memo,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'totalAmount': totalAmount,
      'cm': cm,
      'infoType': InfoType,
      'memo': memo,
    };
  }

  @override
  String toString() {
    return '종류: $infoType\n날짜: $date\n총액: $totalAmount\n누적 주행거리: $cm\n메모: $memo\n';
  }
}
