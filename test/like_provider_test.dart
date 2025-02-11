import 'package:flutter_test/flutter_test.dart';
import 'package:go_moteis/provider/like_provider.dart';

void main() {
  String nameMotel = 'Motel Le Nid';
  group('LikeProvider Testes', () {
    late LikeProvider likeProvider;
    setUp(() {
      likeProvider = LikeProvider();
    });

    test("Deve iniciar sem a curtida", () {
      expect(likeProvider.isLiked(nameMotel), false);
    });

    test("É pra curtir o motel", () {
      likeProvider.toggleLike(nameMotel);
      expect(likeProvider.isLiked(nameMotel), true);
    });
  });
}
