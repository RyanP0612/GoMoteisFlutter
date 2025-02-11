import 'package:flutter/material.dart';

class LikeProvider extends ChangeNotifier {
  final Map<String, bool> _likes = {}; // Guarda o estado dos likes por nome do motel

  bool isLiked(String motelFantasia) {
    return _likes[motelFantasia] ?? false;
  }

  void toggleLike(String motelFantasia) {
    _likes[motelFantasia] = !isLiked(motelFantasia);
    notifyListeners();
  }
}
