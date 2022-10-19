import 'package:flutter/material.dart';
import 'package:rockpaperscissors_app/feature/game/view/game_view.dart';

class GameButton extends StatelessWidget {
  const GameButton({
    Key? key,required this.choice
  }) : super(key: key);
final Choice choice;
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        choice.path(),
        width: 100,
        height: 100,
      ),
    );
  }
}
