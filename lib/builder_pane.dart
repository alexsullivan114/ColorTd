import 'package:colortd/color_td_game.dart';
import 'package:colortd/colors/ColorUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'builder_pane.g.dart';

@widget
Widget builderPane(ColorTdGame game) => Padding(
      padding: const EdgeInsets.all(28.0),
      child: StreamBuilder<GameState>(
          stream: game.stateStream,
          builder: (context, snapshot) {
            final gameState = snapshot.data;
            if (gameState == null) return Container();
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GoldText(gameState.gold),
                ...colors.map((color) => InkWell(
                    child: ColorCircle(color, gameState.selectedColor),
                    onTap: () {
                      game.selectedColor = color;
                    }))
              ],
            );
          }),
    );

@widget
Widget goldText(int goldAmount) =>
    Text("$goldAmount Gold", style: TextStyle(fontSize: 30));

@widget
Widget colorCircle(Color color, Color selectedColor) {
  final selectedBorder = Border.all(color: Colors.black, width: 3.0);
  final border = color == selectedColor ? selectedBorder : null;
  return Container(
      width: 60,
      height: 60,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: color, border: border));
}
