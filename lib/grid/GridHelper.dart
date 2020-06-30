import 'dart:math';
import 'dart:ui';

import '../constants.dart';

mixin GridAware {}

class GridPoint extends Point<int> with GridAware{
  GridPoint(num x, num y) : super(x, y);
}

class GridHelpers {
  static var gridSize = 0.0;
  static Size size = Size(0, 0);

  static int get width => 20;
  static int get height => 30;
  static GridPoint get endPoint => GridPoint(width - 1, height - 1);

  static Rect rect(GridPoint point) {
    return Rect.fromLTWH(
        point.x * gridSize, point.y * gridSize, gridSize, gridSize);
  }

  static Rect fractionRect(GridPoint point) {
    return Rect.fromLTWH(
        point.x * gridSize, point.y * gridSize, gridSize / 2, gridSize / 2);
  }

  static Rect blendRect(GridPoint oldPoint, GridPoint newPoint, double percent) {
    final oldRect = rect(oldPoint);
    final newRect = rect(newPoint);
    final xOffset = (newRect.left - oldRect.left) * percent;
    final yOffset = (newRect.top - oldRect.top) * percent;
    return oldRect.translate(xOffset, yOffset);
  }

  static Rect rectFromGridRect(Rect rect) {
    final x = rect.left * gridSize;
    final y = rect.top * gridSize;
    final width = rect.width * gridSize;
    final height = rect.height * gridSize;
    return Rect.fromLTWH(x, y, width, height);
  }

  static GridPoint pointFromOffset(Offset offset) {
    final x = (offset.dx / gridSize).floor();
    final y = (offset.dy / gridSize).floor();
    return GridPoint(x, y);
  }

  static Offset offsetFromGridPoint(GridPoint point) {
    final x = point.x * gridSize;
    final y = point.y * gridSize;
    return Offset(x, y);
  }
}
