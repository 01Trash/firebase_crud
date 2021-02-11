import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.cyan,
      ),
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String ad, id, kategori;
  double fiyat;

  urunAdiAl(urunAdi) {
    this.ad = urunAdi;
  }

  urunIdsiAl(urunIdsi) {
    this.id = urunIdsi;
  }

  urunKategorisiAl(urunKategorisi) {
    this.kategori = urunKategorisi;
  }

  urunFiyatiAl(urunFiyati) {
    this.fiyat = double.parse(urunFiyati);
  }

  veriEkle() {
    print("Eklendi");

    // Veritabanı yolu
    DocumentReference veriYolu =
        Firestore.instance.collection("Urunler").document(ad);

    // Çoklu veri gönderme işlemi
    Map<String, dynamic> urunler = {
      "urunAdi": ad,
      "urunId": id,
      "urunKategori": kategori,
      "urunFiyat": fiyat,
    };

    veriYolu.set(urunler).whenComplete(() {
      print(ad + " eklendi");
    });
  }

  veriOku() {
    //Firebaseden veri okuma

    DocumentReference veriYolu =
        Firestore.instance.collection("Urunler").document(ad);

    veriYolu.get().then((alinanVeri) {
      print(alinanVeri.data()["urunAdi"]);
      print(alinanVeri.data()["urunId"]);
      print(alinanVeri.data()["urunFiyat"]);
      print(alinanVeri.data()["urunKategori"]);
    });
  }

  veriGuncelle() {
    //Veri yolu
    DocumentReference veriYolu =
        Firestore.instance.collection("Urunler").document(ad);

    //Map ile çoklu veri gönderme
    Map<String, dynamic> urunGuncelVeri = {
      "urunAdi": ad,
      "urunId": id,
      "urunKategori": kategori,
      "urunFiyat": fiyat,
    };

    veriYolu.update(urunGuncelVeri).whenComplete(() {
      print(ad + " güncellendi");
    });
  }

  veriSil() {
    //Veri yolu
    DocumentReference veriYolu =
        Firestore.instance.collection("Urunler").document(ad);

    //Sildirme işlemi
    veriYolu.delete().whenComplete(() {
      print(ad + " adlı ürün silindi");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Envanteri"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Ürün Adı",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                ),
                onChanged: (String urunAdi) {
                  urunAdiAl(urunAdi);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Ürün Id",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                ),
                onChanged: (String urunIdsi) {
                  urunIdsiAl(urunIdsi);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Ürün Kategorisi",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                ),
                onChanged: (String urunKategorisi) {
                  urunKategorisiAl(urunKategorisi);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Ürün Fiyatı",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                ),
                onChanged: (String urunFiyati) {
                  urunFiyatiAl(urunFiyati);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // ignore: deprecated_member_use
                  RaisedButton(
                    color: Colors.cyan,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text("Ekle"),
                    textColor: Colors.white,
                    onPressed: () {
                      veriEkle();
                    },
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    color: Colors.cyan,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text("Oku"),
                    textColor: Colors.white,
                    onPressed: () {
                      veriOku();
                    },
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text("Güncelle"),
                    textColor: Colors.green,
                    onPressed: () {
                      veriGuncelle();
                    },
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    color: Colors.cyan,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text("Sil"),
                    textColor: Colors.brown,
                    onPressed: () {
                      veriSil();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text("Ürün Adı"),
                  ),
                  Expanded(
                    child: Text("Ürün Id"),
                  ),
                  Expanded(
                    child: Text("Ürün Kategori"),
                  ),
                  Expanded(
                    child: Text("Ürün Fiyat"),
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: Firestore.instance.collection("Urunler").snapshots(),
              // ignore: missing_return
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot dokumanSnapshot =
                            snapshot.data.document[index];
                        return Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(dokumanSnapshot["urunAdi"]),
                            ),
                            Expanded(
                              child: Text(dokumanSnapshot["urunId"]),
                            ),
                            Expanded(
                              child: Text(dokumanSnapshot["urunKategori"]),
                            ),
                            Expanded(
                              child:
                                  Text(dokumanSnapshot["urunFiyat"].toString()),
                            ),
                          ],
                        );
                      });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Firestore {
  static var instance;
}
