import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_uygulamasi/data/entity/sepet_yemekler.dart';
import 'package:yemek_uygulamasi/data/repository/sepetyemeklerdao_repository.dart';

class SepetSayfaCubit extends Cubit<List<SepetYemekler>> {
  SepetSayfaCubit() : super(<SepetYemekler>[]);
  var syrepo = SepetYemeklerDaoRepository();
  Future<void> sepeteEkle(
      String sepet_yemek_id,
      String yemek_adi,
      String yemek_resim_adi,
      String yemek_fiyat,
      String yemek_siparis_adet,
      String kullanici_adi) async {
    await syrepo.sepeteEkle(sepet_yemek_id, yemek_adi, yemek_resim_adi,
        yemek_fiyat, yemek_siparis_adet, kullanici_adi);
  }

  Future<void> sepetYukle(String kullanici_adi) async {
    var sepetListe = await syrepo.sepetYukle(kullanici_adi);

    if (sepetListe.isEmpty) {
      emit(<SepetYemekler>[]);
    } else {
      emit(sepetListe);
    }
  }

  Future<void> sil(String kullanici_adi, String sepet_yemek_id) async {
    await syrepo.sil(kullanici_adi, sepet_yemek_id);
    await sepetYukle(kullanici_adi);
  }
}
