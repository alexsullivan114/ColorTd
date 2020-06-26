import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flutter/material.dart';

class EnemyDestinationComponent extends PositionComponent with Resizable {

  @override
  void render(Canvas c) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(size.width - 20, size.height - 20, 20, 20);
    c.drawRect(rect, paint);
  }
}
