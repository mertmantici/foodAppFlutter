import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:yemek_uygulamasi/data/entity/yemekler.dart';
import 'package:yemek_uygulamasi/data/entity/yemekler_cevap.dart';

class YemeklerDaoRepository {
  List<Yemekler> parseYemekler(String cevap) {
    return YemeklerCevap.fromJson(json.decode(cevap)).yemekler;
  }

  Future<List<Yemekler>> yemekleriYukle() async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);

    return parseYemekler(cevap.data.toString());
  }
}
