import 'package:colortd/enemy/enemy_creator_component.dart';
import 'package:colortd/grid/board_grid_component.dart';
import 'package:colortd/tower/tower_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';

import 'enemy/enemy_component.dart';

class GameEngine extends BaseGame with TapDetector {
  GameEngine() {
    add(BoardGridComponent());
    add(EnemyCreatorComponent());
    add(EnemyComponent());
    add(TowerComponent());
  }

  void remove(Component c) {
    components.remove(c);
  }
}
