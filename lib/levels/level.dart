import 'package:colortd/enemy/enemy_component.dart';

class Level {
  final int enemyCount;
  final double spawnTime;
  final EnemyComponent Function() enemyCreator;
  final Level nextLevel;
  int remainingEnemies;

  Level(this.enemyCount, this.spawnTime, this.enemyCreator, this.nextLevel) {
    this.remainingEnemies = this.enemyCount;
  }
}
