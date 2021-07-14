enum InfoType {
  parkingInfo,
  carWashInfo,
  repairInfo,
}

class OtherInformation {
  int? id;
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
  }) {
    id = customHashCode;
  }

  int get customHashCode {
    int code = 0;
    code += DateTime.parse(date!).day;
    code += DateTime.parse(date!).month * 10;
    code += DateTime.parse(date!).year * 100;
    code += totalPrice! * 1000;
    code += cm! * 10000;

    return code;
  }

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
    return 'id: $id\n종류: $infoType\n날짜: $date\n총액: $totalPrice\n누적 주행거리: $cm\n메모: $memo\n';
  }
}
