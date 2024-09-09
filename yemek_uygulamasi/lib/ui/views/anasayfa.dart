import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:yemek_uygulamasi/consts/color.dart';
import 'package:yemek_uygulamasi/data/entity/yemekler.dart';
import 'package:yemek_uygulamasi/ui/cubit/anasayfa_cubit.dart';
import 'package:yemek_uygulamasi/ui/views/detay_Sayfa.dart';
import 'package:yemek_uygulamasi/ui/views/sepet_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;
  var tfArama = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Mert Cafe",
              style: TextStyle(color: AppColors.yaziColor),
            ),
            Lottie.asset("animations/motor.json", height: 70, repeat: true),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 3, color: AppColors.yaziColor)),
                child: Row(
                  children: [
                    aramaYapiliyorMu
                        ? Expanded(
                            flex: 7,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextField(
                                cursorColor: AppColors.yaziColor,
                                style: TextStyle(color: AppColors.yaziColor),
                                controller: tfArama,
                                decoration: const InputDecoration(
                                    hintText: "Yemek Ara",
                                    border: InputBorder.none,
                                    hintStyle:
                                        TextStyle(color: AppColors.yaziColor)),
                                onChanged: (aramaSonucu) {
                                  context
                                      .read<AnasayfaCubit>()
                                      .yemekAra(aramaSonucu);
                                },
                              ),
                            ),
                          )
                        : const Expanded(
                            flex: 7,
                            child: Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Merhaba",
                                style: TextStyle(
                                    color: AppColors.yaziColor, fontSize: 20),
                              ),
                            )),
                    aramaYapiliyorMu
                        ? Expanded(
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    aramaYapiliyorMu = false;
                                    tfArama.text = "";
                                  });
                                  context
                                      .read<AnasayfaCubit>()
                                      .yemekleriYukle();
                                },
                                icon: const Icon(
                                  Icons.clear,
                                  color: AppColors.yaziColor,
                                )),
                          )
                        : Expanded(
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    aramaYapiliyorMu = true;
                                  });
                                },
                                icon: const Icon(
                                  Icons.search,
                                  color: AppColors.yaziColor,
                                )),
                          )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: BlocBuilder<AnasayfaCubit, List<Yemekler>>(
              builder: (context, yemekListesi) {
                if (yemekListesi.isNotEmpty) {
                  return GridView.builder(
                    itemCount: yemekListesi.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1 / 1.4),
                    itemBuilder: (context, index) {
                      var yemek = yemekListesi[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetaySayfa(
                                        yemek: yemek,
                                      ))).then((i) {
                            context.read<AnasayfaCubit>().yemekleriYukle();
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            elevation: 5,
                            shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                    color: AppColors.buttonColor, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            color: AppColors.backgroundColor,
                            child: Column(
                              children: [
                                Image.network(
                                    "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
                                Text(
                                  yemek.yemek_adi,
                                  style: const TextStyle(
                                      fontSize: 20, color: AppColors.yaziColor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, right: 12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "₺${yemek.yemek_fiyat}",
                                        style: const TextStyle(
                                            fontSize: 25,
                                            color: AppColors.yaziColor),
                                      ),
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: AppColors.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: AppColors.yaziColor,
                                                width: 2)),
                                        child: const Icon(
                                          Icons.add,
                                          color: AppColors.yaziColor,
                                          size: 27,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SepetSayfa()));
        },
        child: const Icon(
          Icons.shopping_cart_sharp,
          color: AppColors.yaziColor,
        ),
      ),
    );
  }
}
