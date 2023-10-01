import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const KelimeOyunuApp());

class SoruCevap {
  final String soru;
  final String cevap;

  SoruCevap({required this.soru, required this.cevap});
}

// void main() => runApp(KelimeOyunuApp());

class KelimeOyunuApp extends StatelessWidget {
  const KelimeOyunuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const KelimeOyunu(),
    );
  }
}

class KelimeOyunu extends StatefulWidget {
  const KelimeOyunu({super.key});

  @override
  _KelimeOyunuState createState() => _KelimeOyunuState();
}

class _KelimeOyunuState extends State<KelimeOyunu> {
  List<SoruCevap> sorularCevaplar = [
    SoruCevap(
      soru: "İçerisinde bulunan kadmiyum ve civa gibi ağır metaller, besin kaynaklarına karışıp insan sağlığını da tehdit eder.",
      cevap: "pil",
    ),
    SoruCevap(
      soru: "Çöpe atıldığında çürümez, paslanmaz, çözünmez ve bozulmaz bir yapıdadır. Suyu ve toprağı kirletmesinin yanında yıllarca doğada birikerek sudaki canlılara zarar vermekte hatta ölümlerine bile neden olabilmektedir.",
      cevap: "plastik",
    ),
    SoruCevap(
      soru: "Doğada uzun süre yok olmaz, yüzlerce yıl boyunca aynı kalır.",
      cevap: "cam",
    ),
    SoruCevap(
      soru: "Çevre kirliliğinin önlenmesini ve geri dönüşümden sağlanan gelir ile yürüyemeyen ihtiyaç sahibi engelli kişilere akülü tekerlekli sandalye temin edilmesini sağlar.",
      cevap: "mavikapak",
    ),
    SoruCevap(
      soru: "Ekotoksik özelliğe sahiptir. Alıcı ortamı kirleterek, ortamda yaşayan canlıların yaşam alanlarını yok ederek tahribata yol açar. Suya karıştığı zaman; temiz su yüzeyini kaplar ve suyun hava ile temasını engeller. Havadan suya oksijen transferini önler, zamanla oksijenin azalmasına sebep olur.",
      cevap: "yağ",
    ),
    
    // Diğer soruları ve cevapları buraya ekleyebiliriz.
  ];

  int mevcutSoruIndeksi = 0;
  String cevap = "";
  bool cevapDurumuGoster = true;

  void rastgeleSoruSec() {
    setState(() {
      mevcutSoruIndeksi = Random().nextInt(sorularCevaplar.length);
      cevap = "";
      cevapDurumuGoster = true;
    });
  }

  void cevabiKontrolEt() {
    if (cevap.toLowerCase() == sorularCevaplar[mevcutSoruIndeksi].cevap.toLowerCase()) {
      // Cevap doğruysa
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Cevabınız doğru!'),
      ));
    } else {
      // Cevap yanlışsa
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Cevabınız yanlış.'),
      ));
    }
    setState(() {
      cevapDurumuGoster = true;
    });
  }

  @override
  void initState() {
    super.initState();
    rastgeleSoruSec();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geleceğin Rengi Yeşil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                sorularCevaplar[mevcutSoruIndeksi].soru,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < sorularCevaplar[mevcutSoruIndeksi].cevap.length; i++)
                  Container(
                    width: 40.0,
                    margin: const EdgeInsets.all(5.0),
                    child: TextField(
                      onChanged: (value) {
                        if (i < sorularCevaplar[mevcutSoruIndeksi].cevap.length - 1) {
                          FocusScope.of(context).nextFocus();
                        } else {
                          FocusScope.of(context).unfocus();
                        }
                        setState(() {
                          cevap += value;
                        });
                      },
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20.0),
                      decoration: const InputDecoration(
                        counterText: '',
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                cevabiKontrolEt();
              },
              child: const Text('Cevabı Gönder'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                rastgeleSoruSec();
              },
              child: const Text('Sonraki Soru'),
            ),
            const SizedBox(height: 20.0),
            cevapDurumuGoster
                ? const Text(
                    '',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}