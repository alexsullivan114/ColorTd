import 'dart:collection';
import 'dart:math';

import 'package:colortd/enemy/enemy_component.dart';
import 'package:colortd/tower/tower_component.dart';
import 'package:flutter/cupertino.dart';

class EnemyMovementCoordinator {
  Map<Point, Point> vectorField = {};

  void calculateVectorField(List<TowerComponent> towers, Size size, Point endPoint) {
    // First make a grid out of our size
    Set<Point> grid = Set();
    for (int i = 0; i < size.width; i++) {
      for (int j = 0; j < size.height; j++) {
        Point point = Point(i, j);
        grid.add(point);
      }
    }
    // Now remove all of the points occupied by towers
    for (TowerComponent component in towers) {
      final rect = component.toRect();
      for (int i = rect.left.toInt(); i < rect.left + rect.width; i++) {
        for (int j = rect.top.toInt(); j < rect.top + rect.height; j++) {
          Point point = Point(i, j);
          grid.remove(point);
        }
      }
    }

    // Now calculate the vector field
    final frontier = Queue<Point>();
    frontier.add(endPoint);
    final Map<Point, Point> cameFrom = {};
    while (frontier.isNotEmpty) {
      // TODO: Might want remove last? Not sure
      final current = frontier.removeFirst();
      for (Point next in neighbors(current, grid)) {
        if (next == Point(0, 0)) {
          print("Wowee!");
        }
        if (!cameFrom.containsKey(next)) {
          frontier.add(next);
          cameFrom[next] = current;
        }
      }
    }

    this.vectorField = cameFrom;
  }

  Set<Point> neighbors(Point point, Set<Point> grid) {
    final topLeft = Point(point.x - 1, point.y - 1);
    final topRight = Point(point.x + 1, point.y - 1);
    final top = Point(point.x, point.y - 1);
    final left = Point(point.x - 1, point.y);
    final right = Point(point.x + 1, point.y);
    final bottomLeft = Point(point.x - 1, point.y + 1);
    final bottom = Point(point.x, point.y + 1);
    final bottomRight = Point(point.x + 1, point.y + 1);

    final returnSet = Set<Point>();
    if (grid.contains(topLeft)) returnSet.add(topLeft);
    if (grid.contains(topRight)) returnSet.add(topRight);
    if (grid.contains(top)) returnSet.add(top);
    if (grid.contains(left)) returnSet.add(left);
    if (grid.contains(right)) returnSet.add(right);
    if (grid.contains(bottomLeft)) returnSet.add(bottomLeft);
    if (grid.contains(bottom)) returnSet.add(bottom);
    if (grid.contains(bottomRight)) returnSet.add(bottomRight);
    return returnSet;
  }
}

enum Direction {
  UP,
  DOWN,
  LEFT,
  RIGHT,
  TOP_RIGHT,
  TOP_LEFT,
  BOTTOM_LEFT,
  BOTTOM_RIGHT
}
