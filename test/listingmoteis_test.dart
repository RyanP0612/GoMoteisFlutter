import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_moteis/components/ListingMoteis.dart';
import 'package:provider/provider.dart';
import 'package:go_moteis/provider/like_provider.dart';

void main() {
  testWidgets('Deve exibir um motel', (WidgetTester tester) async {
    final mockData = {
      "data": {
        "moteis": [
          {
            "fantasia": "Motel Teste",
            "logo":
                "https://cdn.guiademoteis.com.br/imagens/logotipos/3148-le-nid.gif",
            "bairro": "Leticia - LI",
            "distancia": 612.5,
            "suites": []
          }
        ]
      }
    };
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (_) => LikeProvider(),
      child: MaterialApp(
        home: Scaffold(
          body: Listingmoteis(data: mockData),
        ),
      ),
    ));
    expect(find.text('Motel Teste'), findsOneWidget);
    expect(find.text('612.5Km - Leticia - LI'), findsOneWidget);
  });

  testWidgets('é pra alternar o like', (WidgetTester tester) async {
    final mockData = {
      "data": {
        "moteis": [
          {
            "fantasia": "Motel Teste",
            "bairro": "Centro - SP",
            "distancia": 10.5,
            "suites": []
          }
        ]
      }
    };

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => LikeProvider(),
        child: MaterialApp(
          home: Scaffold(body: Listingmoteis(data: mockData)),
        ),
      ),
    );

    final likeButton = find.byIcon(Icons.favorite_border);
    expect(likeButton, findsOneWidget);

    await tester.tap(likeButton);
    await tester.pump();

    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });
}
