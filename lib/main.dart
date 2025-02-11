import 'package:flutter/material.dart';
import 'package:go_moteis/pages/HomePage.dart';
import 'package:go_moteis/provider/like_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => LikeProvider()), // Adiciona o Provider aqui
      ],
      child: const MyappGo(),
    ),
  );
}

class MyappGo extends StatelessWidget {
  const MyappGo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Go Moteis',
      home: Homepage(),
    );
  }
}
