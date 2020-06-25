import 'enemy.dart';

class Level {
  final List<Enemy> enemies;
  final int enemyDx;
  Level(this.enemies, this.enemyDx);
}

final Level level1 = Level([Enemy(), Enemy(), Enemy()], 40);
