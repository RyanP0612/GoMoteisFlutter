import 'package:flutter/material.dart';

class Containeravaliacao extends StatelessWidget {
  final double nota;
  final int avaliacoes;
  final List<String>? elogiosFeitos;
  const Containeravaliacao(
      {super.key,
      required this.nota,
      required this.avaliacoes,
      this.elogiosFeitos});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 5),
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: Colors.orangeAccent,
                    width: 2,
                    style: BorderStyle.solid)),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.orangeAccent,
                  size: 20,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  nota.toString(),
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 3,
          ),
          GestureDetector(
            onTap: () {
              print("Gerar o popup da avaliação geral");
            },
            child: Text('${avaliacoes} avaliações ↓'),
          )
        ],
      ),
    );
  }
}
