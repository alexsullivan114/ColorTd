import 'dart:ui';

import 'package:colortd/game_engine.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flutter/material.dart';

class EnemyComponent extends PositionComponent with Resizable, HasGameRef<GameEngine> {
  Rect position = Rect.fromLTRB(0, 0, 20, 20);

  @override
  void render(Canvas c) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    c.drawRect(position, paint);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position = position.shift(Offset(1, 1));
    if (position.left < 0 || position.right > size.width || position.bottom > size.height || position.top < 0) {
      gameRef.remove(this);
    }
  }
}
