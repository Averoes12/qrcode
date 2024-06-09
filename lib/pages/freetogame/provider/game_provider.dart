import 'package:flutter/material.dart';
import 'package:qrcode_app/source/game_source.dart';

import '../../../models/game/game.dart';

enum GameStatus {
  init,
  loading,
  error,
  success
}
class GameProvider extends ChangeNotifier{
  GameStatus status = GameStatus.init;
  List<Game> _games = [];
  List<Game> get games => _games;

  fetchLiveGame() async {
    status = GameStatus.loading;
    notifyListeners();

    final list = await  GameSource.getLiveGame();
    if(list == null) {
      status = GameStatus.error;
      notifyListeners();
      return;
    }

    _games = list;
    status = GameStatus.success;
    notifyListeners();
  }
}