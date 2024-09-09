import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:yemek_uygulamasi/consts/color.dart';
import 'package:yemek_uygulamasi/data/entity/yemekler.dart';
import 'package:yemek_uygulamasi/ui/cubit/sepet_sayfa_cubit.dart';

class DetaySayfa extends StatefulWidget {
  Yemekler yemek;

  DetaySayfa({required this.yemek});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  int adet = 0;
  int toplam = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
          color: AppColors.yaziColor,
        ),
        backgroundColor: AppColors.primaryColor,
        title: Text(
          widget.yemek.yemek_adi,
          style: const TextStyle(color: AppColors.yaziColor),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(
                "http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}"),
            Text(
              "₺${widget.yemek.yemek_fiyat}",
              style: TextStyle(fontSize: 40, color: AppColors.yaziColor),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  style: IconButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                              width: 2, color: AppColors.yaziColor))),
                  onPressed: () {
                    setState(() {
                      if (adet > 0) {
                        adet--;
                        toplam = (int.parse(widget.yemek.yemek_fiyat)) * adet;
                      }
                    });
                  },
                  icon: Icon(Icons.exposure_minus_1_sharp),
                  color: AppColors.yaziColor,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "$adet",
                  style:
                      const TextStyle(fontSize: 40, color: AppColors.yaziColor),
                ),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                  style: IconButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                              width: 2, color: AppColors.yaziColor))),
                  onPressed: () {
                    setState(() {
                      adet++;
                      toplam = (int.parse(widget.yemek.yemek_fiyat)) * adet;
                    });
                  },
                  icon: Icon(Icons.exposure_plus_1_sharp),
                  color: AppColors.yaziColor,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text(
                      "Toplam",
                      style:
                          TextStyle(fontSize: 30, color: AppColors.yaziColor),
                    ),
                    Text(
                      "₺${toplam}",
                      style:
                          TextStyle(fontSize: 30, color: AppColors.yaziColor),
                    ),
                  ],
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                width: 2, color: AppColors.yaziColor))),
                    onPressed: () {
                      context.read<SepetSayfaCubit>().sepeteEkle(
                          widget.yemek.yemek_id,
                          widget.yemek.yemek_adi,
                          widget.yemek.yemek_resim_adi,
                          widget.yemek.yemek_fiyat,
                          adet.toString(),
                          "mert_mantici");
                      _showLottieDialog();
                    },
                    child: const Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        "Sepete Ekle",
                        style:
                            TextStyle(fontSize: 30, color: AppColors.yaziColor),
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showLottieDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Kullanıcının dialogu kapatmaması için
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor:
              Colors.transparent, // Dialog arka plan rengini şeffaf yapıyoruz
          elevation: 0, // Dialog gölgesini kaldırıyoruz
          child: Container(
            color: Colors
                .transparent, // Animasyon etrafındaki renk arka planını da şeffaf yapıyoruz
            child: Lottie.asset(
              'animations/sepet.json',
              width: 200,
              height: 200,
              repeat: false,
              onLoaded: (composition) {
                // Animasyon süresi kadar bekleyip dialogu kapatmak
                Future.delayed(composition.duration, () {
                  Navigator.of(context).pop(); // Dialogu kapatma
                });
              },
            ),
          ),
        );
      },
    );
  }
}
