import 'package:colortd/enemy/enemy_component.dart';
import 'package:colortd/levels/level.dart';
import 'package:colortd/levels/level_3.dart';

class Level2 extends Level {
  Level2()
      : super(40, 0.5, () {
          return EnemyComponent(maxHealth: 5, speed: 9);
        }, Level3());
}
