import 'dart:ui';

import 'package:colortd/grid/GridHelper.dart';
import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';

class TowerComponent extends PositionComponent {

  Rect gridRect = Rect.fromLTWH(0, 0, 0, 0);

  @override
  void render(Canvas c) {
    final paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    c.drawRect(GridHelpers.rectFromGridRect(gridRect), paint);
  }
}
