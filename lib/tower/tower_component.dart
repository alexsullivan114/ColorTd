import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';

class TowerComponent extends PositionComponent {

  @override
  void render(Canvas c) {
    final paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    c.drawRect(Rect.fromLTWH(100, 100, 50, 50), paint);
  }
}
