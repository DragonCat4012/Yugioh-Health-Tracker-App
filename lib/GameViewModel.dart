import 'package:flutter/cupertino.dart';

import 'Util/Game.dart';

class GameViewModel extends ChangeNotifier {
  int health1 = 8000; // purple
  int health2 = 8000; //orange
  int maxHealth = 8000;

  GameViewModel(health) {
    maxHealth = health;
    health1 = maxHealth;
    health2 = maxHealth;
  }

  GameViewModel.fromGame(int health, Game game ) {
    maxHealth = health;
    health1 = maxHealth;
    health2 = maxHealth;

    if(game.log.isNotEmpty) {
      health1 = game.log.first.meHealth;
      health2 = game.log.first.enemyHealth;
    }
  }

  //getter
  String get_health1() {
    return health1.toString();
  }

  String get_health2() {
    return health2.toString();
  }

  edit_health(int player, int value) {
    if (player == 1) {
      health1 += value;
    } else {
      health2 += value;
    }
    notifyListeners();
  }
}
