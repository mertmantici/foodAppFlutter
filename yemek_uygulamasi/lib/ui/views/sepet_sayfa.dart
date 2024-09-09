import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:yemek_uygulamasi/consts/color.dart';
import 'package:yemek_uygulamasi/data/entity/sepet_yemekler.dart';
import 'package:yemek_uygulamasi/ui/cubit/sepet_sayfa_cubit.dart';

class SepetSayfa extends StatefulWidget {
  const SepetSayfa({super.key});

  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {
  @override
  void initState() {
    super.initState();
    context.read<SepetSayfaCubit>().sepetYukle("mert_mantici");
  }

  int toplamHesapla(List<SepetYemekler> sepetYemekler) {
    int toplam = 0;
    for (var yemek in sepetYemekler) {
      toplam +=
          int.parse(yemek.yemek_fiyat) * int.parse(yemek.yemek_siparis_adet);
    }
    return toplam;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.yaziColor,
            )),
        backgroundColor: AppColors.primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Sepet",
              style: TextStyle(color: AppColors.yaziColor),
            ),
            Lottie.asset("animations/motor.json", height: 70, repeat: true),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: BlocBuilder<SepetSayfaCubit, List<SepetYemekler>>(
              builder: (context, sepetYemekler) {
                if (sepetYemekler.isNotEmpty) {
                  int toplam = toplamHesapla(sepetYemekler);

                  return ListView.builder(
                    itemCount: sepetYemekler.length,
                    itemBuilder: (context, index) {
                      var sepetYemek = sepetYemekler[index];

                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: AppColors.buttonColor, width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          color: AppColors.backgroundColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: Image.network(
                                      "http://kasimadalan.pe.hu/yemekler/resimler/${sepetYemek.yemek_resim_adi}"),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    sepetYemek.yemek_adi,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: AppColors.yaziColor),
                                  ),
                                  Text(
                                    "Fiyat : ₺${sepetYemek.yemek_fiyat}",
                                    style: const TextStyle(
                                        color: AppColors.yaziColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      "Adet : ${sepetYemek.yemek_siparis_adet}",
                                      style: const TextStyle(
                                          color: AppColors.yaziColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 28.0, right: 5.0),
                                child: Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        context.read<SepetSayfaCubit>().sil(
                                            sepetYemek.kullanici_adi,
                                            sepetYemek.sepet_yemek_id);
                                      },
                                      icon: const Icon(Icons.delete),
                                      color: AppColors.buttonColor,
                                      iconSize: 35,
                                    ),
                                    Text(
                                      "₺${int.parse(sepetYemek.yemek_fiyat) * int.parse(sepetYemek.yemek_siparis_adet)}",
                                      style: const TextStyle(
                                          color: AppColors.yaziColor,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text(
                      "Sepetiniz boş",
                      style:
                          TextStyle(color: AppColors.yaziColor, fontSize: 20),
                    ),
                  );
                }
              },
            ),
          ),
          Expanded(child: BlocBuilder<SepetSayfaCubit, List<SepetYemekler>>(
            builder: (context, sepetYemekler) {
              int toplam = toplamHesapla(sepetYemekler);
              return Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: AppColors.yaziColor, // Çerçeve rengi
                      width: 2.0, // Çerçeve kalınlığı
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 6.0, bottom: 8.0, right: 18.8, left: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Sepet Tutarı :",
                            style: TextStyle(
                                color: AppColors.yaziColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "₺$toplam",
                            style: const TextStyle(
                                color: AppColors.yaziColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.backgroundColor,
                          side: const BorderSide(
                              width: 2, color: AppColors.yaziColor),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0)))),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Text(
                          "SEPETİ ONAYLA",
                          style: TextStyle(
                              color: AppColors.yaziColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
        ],
      ),
    );
  }
}
