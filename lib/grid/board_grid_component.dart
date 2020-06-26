import 'dart:math';

import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class BoardGridComponent extends PositionComponent with Resizable{

  @override
  void render(Canvas c) {
    final gridSize = min(size.width / HORIZONTAL_GRID_COUNT,
        size.height / VERTICAL_GRID_COUNT);
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;
    for (int i = 0; i < HORIZONTAL_GRID_COUNT; i++) {
      for (int j = 0; j < VERTICAL_GRID_COUNT; j++) {
        final gridCell =
        Rect.fromLTWH(i * gridSize, j * gridSize, gridSize, gridSize);
        c.drawRect(gridCell, paint);
      }
    }
  }
}
