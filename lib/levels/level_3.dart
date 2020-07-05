import 'package:colortd/enemy/enemy_component.dart';
import 'package:colortd/levels/level.dart';

class Level3 extends Level {
  Level3()
      : super(400000, 1.5, () {
    return EnemyComponent(maxHealth: 50, speed: 8);
  }, null);
}
