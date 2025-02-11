import 'package:flutter/material.dart';
import 'package:go_moteis/components/ContainerAvaliacao.dart';
import 'package:go_moteis/components/ButtonReservar.dart';
import 'package:go_moteis/provider/like_provider.dart';
import 'package:provider/provider.dart';

class Listingmoteis extends StatefulWidget {
  final Map<String, dynamic> data;

  const Listingmoteis({Key? key, required this.data}) : super(key: key);

  @override
  State<Listingmoteis> createState() => _ListingmoteisState();
}

class _ListingmoteisState extends State<Listingmoteis> {
  late PageController _pageController;
  int activePage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.95);
  }

  String encontrarMenorValor(List<dynamic> periodos) {
    List<double> valores = [];
    for (var periodo in periodos) {
      if (periodo['valorTotal'] != null) {
        valores.add(periodo['valorTotal']);
      }
    }
    if (valores.isNotEmpty) {
      valores.sort();
      double precoMinimo = valores.first;
      return 'A partir de R\$${precoMinimo.toString()}';
    }
    return 'Sem preço';
  }

  @override
  Widget build(BuildContext context) {
    var moteis = widget.data['data']?['moteis'] ?? [];
    var likeProvider = Provider.of<LikeProvider>(context);
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          // height: MediaQuery.of(context).size.height,
          // color: Colors.white,
          // width: MediaQuery.of(context).size.width,
          child: moteis.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: moteis.map<Widget>((motel) {
                    var suites = motel['suites'] ?? [];
                    String motelFantasia =
                        motel['fantasia'] ?? "Nome Desconhecido";
                    bool isLiked = likeProvider.isLiked(motelFantasia);
                    return Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  motel["logo"] ?? "",
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.image_not_supported),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    motel["fantasia"] ?? "Nome do Motel",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19),
                                  ),
                                  Text(
                                      '${motel['distancia'] ?? 'Distância'}Km - ${motel["bairro"] ?? "Localização"}'),
                                  Containeravaliacao(
                                      nota: 4.5, avaliacoes: 115),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  likeProvider.toggleLike(motelFantasia);
                                },
                                icon: Icon(
                                  isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color:
                                      isLiked ? Colors.red : Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                          if (suites.isNotEmpty)
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9)),
                                // color: Colors.grey[200],
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: PageView.builder(
                                  itemCount: suites.length,
                                  pageSnapping: true,
                                  controller: _pageController,
                                  onPageChanged: (page) {
                                    setState(() {
                                      activePage = page;
                                    });
                                  },
                                  itemBuilder: (context, suiteIndex) {
                                    var suite = suites[suiteIndex];

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              // margin: EdgeInsets.all(10),
                                              padding: EdgeInsets.all(12),
                                              // padding: EdgeInsets.all(100),
                                              // height: 400,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.79,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(9)),
                                              ),

                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(9)),
                                                    child: Image.network(
                                                      suite['fotos'][0],
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 12.0),
                                                    child: Text(
                                                      "${suite["nome"]}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(12),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.79,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(9)),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Center(
                                                child: Wrap(
                                                  spacing:
                                                      8.0, // Espaço horizontal entre os itens
                                                  runSpacing:
                                                      8.0, // Espaço vertical quando quebra a linha
                                                  children: List.generate(
                                                    suite['itens'] != null
                                                        ? (suite['itens']
                                                                    .length >
                                                                4
                                                            ? 4
                                                            : suite['itens']
                                                                .length)
                                                        : 0,
                                                    (index) => Text(
                                                        "${suite['itens'][index]['nome']} √"),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    print(
                                                        "pop up de itens totais");
                                                  },
                                                  child: Text("Ver mais..."))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          // margin: EdgeInsets.all(10),
                                          padding: EdgeInsets.all(12),
                                          // padding: EdgeInsets.all(100),
                                          // height: 400,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.79,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(9)),
                                          ),

                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "${suite['periodos'][2]['tempoFormatado']}",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        "R\$ ${suite['periodos'][2]['valorTotal']}",
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      print("entrar na suite");
                                                    },
                                                    child: Text(
                                                      ">",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                            )
                        ],
                      ),
                    );
                  }).toList(),
                ),
        ),
      ],
    );
  }
}
