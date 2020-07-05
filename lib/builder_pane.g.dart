// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'builder_pane.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class BuilderPane extends StatelessWidget {
  const BuilderPane(this.game, {Key key}) : super(key: key);

  final ColorTdGame game;

  @override
  Widget build(BuildContext _context) => builderPane(game);
}

class GoldText extends StatelessWidget {
  const GoldText(this.goldAmount, {Key key}) : super(key: key);

  final int goldAmount;

  @override
  Widget build(BuildContext _context) => goldText(goldAmount);
}

class ColorCircle extends StatelessWidget {
  const ColorCircle(this.color, this.selectedColor, {Key key})
      : super(key: key);

  final Color color;

  final Color selectedColor;

  @override
  Widget build(BuildContext _context) => colorCircle(color, selectedColor);
}
