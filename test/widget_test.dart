import 'dart:io';

void main() {
  showData();
}

void showData() {
  startTast();
  accessData();
  fetchData();
}

void startTast() {
  String info1 = '요청수행 시작';
  print(info1);
}

void accessData() {
  String info1 = '데이터 접속';
  print(info1);
}

void fetchData() {
  String info1 = '라스트';
  print(info1);
}