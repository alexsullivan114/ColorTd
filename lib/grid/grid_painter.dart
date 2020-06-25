import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {
  final int verticalGridCount;
  final int horizontalGridCount;
  final double gridSize;

  GridPainter(this.verticalGridCount, this.horizontalGridCount, this.gridSize);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;
    for (int i = 0; i < horizontalGridCount; i++) {
      for (int j = 0; j < verticalGridCount; j++) {
        final gridCell =
            Rect.fromLTWH(i * gridSize, j * gridSize, gridSize, gridSize);
        canvas.drawRect(gridCell, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
