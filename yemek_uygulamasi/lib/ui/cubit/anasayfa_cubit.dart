import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_uygulamasi/data/entity/yemekler.dart';
import 'package:yemek_uygulamasi/data/repository/yemeklerdao_repository.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>> {
  AnasayfaCubit() : super(<Yemekler>[]);

  var yrepo = YemeklerDaoRepository();

  Future<void> yemekleriYukle() async {
    var liste = await yrepo.yemekleriYukle();
    emit(liste);
  }

  Future<void> yemekAra(String arama) async {
    var liste = await yrepo.yemekleriYukle();
    final filtrelenmisYemekler = liste.where((yemek) {
      return yemek.yemek_adi.toLowerCase().contains(arama.toLowerCase());
    }).toList();
    emit(filtrelenmisYemekler);
  }
}
