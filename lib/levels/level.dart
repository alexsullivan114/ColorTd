import 'package:colortd/enemy/enemy_component.dart';

class Level {
  final int enemyCount;
  final int spawnTime;
  final EnemyComponent Function() enemyCreator;
  int remainingEnemies;

  Level(this.enemyCount, this.spawnTime, this.enemyCreator) {
    this.remainingEnemies = this.enemyCount;
  }
}
