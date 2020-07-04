import 'package:colortd/enemy/enemy_component.dart';
import 'package:colortd/levels/level.dart';

class Level1 extends Level {
  Level1()
      : super(20, 1, () {
          return EnemyComponent(maxHealth: 10, speed: 2);
        });
}
