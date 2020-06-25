import 'package:flutter/cupertino.dart';

import 'enemy.dart';
import 'level.dart';
import 'positionable.dart';

class GameEngine {
  final Size boardSize;
  final Level level = level1;
  List<Positionable<Enemy>> enemies;

  GameEngine(this.boardSize) {
    for (int i = 0; i < level.enemies.length; i++) {
      final enemy = level.enemies[i];
      final dx = level.enemyDx * -i;
      final positionedEnemy = Positionable(enemy, dx, boardSize.height ~/ 2);
      enemies.insert(i, positionedEnemy);
    }
  }

  void tick() {

  }
}
