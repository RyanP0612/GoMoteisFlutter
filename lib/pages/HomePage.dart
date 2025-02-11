import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:go_moteis/components/CarouselOfertas.dart';
import 'package:go_moteis/components/ListingMoteis.dart';
import 'package:go_moteis/components/drawer.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Map<String, dynamic> data =
      {}; // Alterado para Map para refletir a estrutura do JSON

  @override
  void initState() {
    super.initState();
    _loadMockData();
  }

  Future<void> _loadMockData() async {
    try {
      // Carrega o arquivo JSON como uma string
      String jsonString = await rootBundle.loadString('lib/mock/APILocal.json');
      setState(() {
        data = jsonDecode(jsonString); // Decodifica o JSON
      });
    } catch (e) {
      print("Erro ao carregar JSON: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.grey[200],
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Container(
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(9)),
            width: 250,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 130,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.flag_sharp,
                        color: Colors.red,
                      ),
                      Text(
                        "Ir agora",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 120,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(9)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: Colors.white,
                      ),
                      Text(
                        "Ir outro dia",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
      drawerScrimColor: Colors.grey,
      drawer: MyDrawer(),
      backgroundColor: Colors.grey[300],
      body: ListView(
        children: [
          Column(
            children: [
              Carouselofertas(data: data),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.black,
              ),
              Listingmoteis(
                data: data,
              )
            ],
          ),
        ],
      ),
    );
  }
}
