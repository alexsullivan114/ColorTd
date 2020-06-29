import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flutter/material.dart';

import '../grid/GridHelper.dart';

class EnemyDestinationComponent extends PositionComponent with Resizable {
  @override
  void render(Canvas c) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final point = GridPoint(GridHelpers.width - 1, GridHelpers.height - 1);
    final rect = GridHelpers.rect(point);
    c.drawRect(rect, paint);
  }
}
