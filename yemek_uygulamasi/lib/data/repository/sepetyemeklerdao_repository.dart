import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:yemek_uygulamasi/data/entity/sepet_yemekler.dart';
import 'package:yemek_uygulamasi/data/entity/sepet_yemekler_cevap.dart';

class SepetYemeklerDaoRepository {
  List<SepetYemekler> parseSepetYemekler(String cevap) {
    return SepetYemeklerCevap.fromJson(json.decode(cevap)).sepetYemekler;
  }

  Future<void> sepeteEkle(
      String sepet_yemek_id,
      String yemek_adi,
      String yemek_resim_adi,
      String yemek_fiyat,
      String yemek_siparis_adet,
      String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var veri = {
      "sepet_yemek_id": sepet_yemek_id,
      "yemek_adi": yemek_adi,
      "yemek_resim_adi": yemek_resim_adi,
      "yemek_fiyat": yemek_fiyat,
      "yemek_siparis_adet": yemek_siparis_adet,
      "kullanici_adi": kullanici_adi
    };
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
  }

  Future<List<SepetYemekler>> sepetYukle(String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri = {"kullanici_adi": kullanici_adi};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));

    return parseSepetYemekler(cevap.data.toString());
  }

  Future<void> sil(String kullanici_adi, String sepet_yemek_id) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {
      "kullanici_adi": kullanici_adi,
      "sepet_yemek_id": sepet_yemek_id
    };
    await Dio().post(url, data: FormData.fromMap(veri));
  }
}
