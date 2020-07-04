import 'dart:ui';

import 'package:colortd/grid/GridHelper.dart';
import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';

class EnemyCreatorComponent extends PositionComponent {

  @override
  void render(Canvas c) {
    final paint = Paint()
    ..color = Colors.red
    ..strokeWidth = 2
    ..style = PaintingStyle.fill;

    final rect = GridHelpers.rect(GridPoint(0, 0));
    c.drawRect(rect, paint);
  }
}
