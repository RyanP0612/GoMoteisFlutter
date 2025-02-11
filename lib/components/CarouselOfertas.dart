import 'package:flutter/material.dart';
import 'package:go_moteis/components/ButtonReservar.dart';

class Carouselofertas extends StatefulWidget {
  final Map<String, dynamic> data;
  const Carouselofertas({super.key, required this.data});

  @override
  State<Carouselofertas> createState() => _CarouselofertasState();
}

class _CarouselofertasState extends State<Carouselofertas> {
  late PageController _pageController;
  int activePage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }

  String encontrarDesconto(List<dynamic> periodos) {
    List<double> descontos = [];
    for (var periodo in periodos) {
      if (periodo['desconto'] != null) {
        descontos.add(periodo['desconto']['desconto']);
      }
    }
    if (descontos.isNotEmpty) {
      descontos.sort();
      double descontoMaximo = descontos.last;
      return '${descontoMaximo.toString()}% de desconto';
    }
    return 'Sem desconto';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          // height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          child: widget.data.isEmpty
              ? Center(child: CircularProgressIndicator()) // Exibe um loading
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.data['data']['moteis']?.length ?? 0,
                  itemBuilder: (context, index) {
                    var motel =
                        widget.data['data']['moteis'][index]; // Acesso ao motel
                    var suites = motel['suites']; // Acesso às suítes

                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                        color: Colors.grey[200],
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 6,
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
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.7,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(9)),
                                        child: Image.network(
                                          suite['fotos'][0],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // width: double.infinity,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              motel['fantasia'] ??
                                                  'Nome do Motel',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              motel['bairro'] ?? 'Bairro',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              encontrarDesconto(
                                                  suite['periodos']),
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              encontrarMenorValor(
                                                  suite['periodos']),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Buttonreservar(
                                              onTap: () {},
                                              buttonColor: Colors.green,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:
                                        indicators(suites.length, activePage))
                              ],
                            );
                          }),
                    );
                  },
                ),
        ),
      ],
    );
  }
}


// Text(motel['fantasia'] ?? 'Nome do Motel',
                            //     style: TextStyle(
                            //         fontSize: 18, fontWeight: FontWeight.bold)),
                            // Text(motel['bairro'] ?? 'Bairro',
                            //     style: TextStyle(fontSize: 16)),
                            // Text("Distância: ${motel['distancia']} km",
                            //     style: TextStyle(fontSize: 14)),
                            // SizedBox(height: 10),

                            // // Exibindo as suítes disponíveis
                            // Text('Suítes disponíveis:',
                            //     style: TextStyle(
                            //         fontSize: 16, fontWeight: FontWeight.bold)),