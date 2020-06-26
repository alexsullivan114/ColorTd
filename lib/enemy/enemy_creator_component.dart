import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';

class EnemyCreatorComponent extends PositionComponent {

  @override
  void render(Canvas c) {
    final paint = Paint()
    ..color = Colors.red
    ..strokeWidth = 2
    ..style = PaintingStyle.fill;

    final rect = Rect.fromLTRB(0, 0, 20, 20);
    c.drawRect(rect, paint);
  }
}
