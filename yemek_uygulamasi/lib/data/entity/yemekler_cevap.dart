import 'package:yemek_uygulamasi/data/entity/yemekler.dart';

class YemeklerCevap {
  List<Yemekler> yemekler;
  int success;

  YemeklerCevap({required this.yemekler, required this.success});

  factory YemeklerCevap.fromJson(Map<String, dynamic> json) {
    var success = json["success"] as int;
    var jsonArray = json["yemekler"] as List;

    var yemekler = jsonArray
        .map((jsonArrayNesnesi) => Yemekler.fromJson(jsonArrayNesnesi))
        .toList();
    return YemeklerCevap(yemekler: yemekler, success: success);
  }
}
