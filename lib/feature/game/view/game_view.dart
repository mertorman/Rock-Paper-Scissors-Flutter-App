import 'dart:math';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:rockpaperscissors_app/feature/game/constant/score.dart';
import 'package:rockpaperscissors_app/feature/game/view/widgets/game_button_widget.dart';
import 'package:rockpaperscissors_app/feature/game/view/widgets/snackbar_widget.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool onTapEnabled = true;
  static int matchNumber = 1;
  double playAgainButtonOpacity = 0;

  int computerIndex = 3;
  int playerIndex = 3;
  bool rockBorder = false;
  bool paperBorder = false;
  bool scissorsBorder = false;

  bool rockBorderComputer = false;
  bool paperBorderComputer = false;
  bool scissorsBorderComputer = false;

  double rockOpacity = 1;
  double paperOpacity = 1;
  double scissorsOpacity = 1;

  double computerRockOpacity = 0.3;
  double computerPaperOpacity = 0.3;
  double computerScissorsOpacity = 0.3;

  opacityChange(Choice choice) async {
    switch (choice) {
      case Choice.rock:
        setState(() {
          playerIndex = 0;
          paperOpacity = 0.3;
          scissorsOpacity = 0.3;
        });
        break;
      case Choice.paper:
        setState(() {
          playerIndex = 1;
          rockOpacity = 0.3;
          scissorsOpacity = 0.3;
        });
        break;
      case Choice.scissors:
        setState(() {
          playerIndex = 2;
          paperOpacity = 0.3;
          rockOpacity = 0.3;
        });
    }
  }

  resetSettings() {
    setState(() {
      matchNumber++;
      winner();
      rockOpacity = 1;
      paperOpacity = 1;
      scissorsOpacity = 1;
      paperBorder = false;
      rockBorder = false;
      scissorsBorder = false;
      playerIndex = 3;
      computerIndex = 3;
      rockBorderComputer = false;
      paperBorderComputer = false;
      scissorsBorderComputer = false;
      computerRockOpacity = 0.3;
      computerPaperOpacity = 0.3;
      computerScissorsOpacity = 0.3;
    });
  }

  resetUi() {
    onTabStatusChange();
    setState(() {
      Score.computerScore = 0;
      Score.playerScore = 0;
      matchNumber = 1;
      playAgainButtonOpacity = 0;
    });
  }

  playComputer(Choice playerChoice) async {
    Choice computerChoice =
        Choice.values[Random().nextInt(Choice.values.length)];
    setState(() {
      computerIndex = computerChoice.index;
    });

    switch (computerChoice) {
      case Choice.rock:
        setState(() {
          computerRockOpacity = 1;
          if (playerChoice == Choice.paper) {
            Score.playerScore++;
            paperBorder = true;
          } else if (playerChoice == Choice.scissors) {
            Score.computerScore++;
            scissorsBorderComputer = true;
          }
        });
        break;
      case Choice.paper:
        setState(() {
          computerPaperOpacity = 1;
          if (playerChoice == Choice.scissors) {
            Score.playerScore++;
            scissorsBorder = true;
          } else if (playerChoice == Choice.rock) {
            Score.computerScore++;
            rockBorderComputer = true;
          }
        });
        break;
      case Choice.scissors:
        setState(() {
          computerScissorsOpacity = 1;
          if (playerChoice == Choice.rock) {
            Score.playerScore++;
            rockBorder = true;
          } else if (playerChoice == Choice.paper) {
            Score.computerScore++;
            paperBorderComputer = true;
          }
        });
    }
  }

  void onTabStatusChange() {
    setState(() {
      onTapEnabled = !onTapEnabled;
    });
  }

  void winner() {
    if (Score.playerScore > Score.computerScore && matchNumber == 5) {
      var snackBar = SnackBarWidgets.SnackBarWidget(
          'Congratulations', 'You win!', ContentType.success);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      onTabStatusChange();
      setState(() {
        playAgainButtonOpacity = 1;
      });
    } else if (Score.computerScore > Score.playerScore && matchNumber == 5) {
      var snackBar = SnackBarWidgets.SnackBarWidget(
          'You Lost', 'Play again!', ContentType.failure);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      onTabStatusChange();
      setState(() {
        playAgainButtonOpacity = 1;
      });
    } else if (Score.computerScore == Score.playerScore && matchNumber == 5) {
      var snackBar = SnackBarWidgets.SnackBarWidget(
          'It is a Draw', 'Draw!', ContentType.warning);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      onTabStatusChange();
      setState(() {
        playAgainButtonOpacity = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCFDFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 3),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '${Score.playerScore}',
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      const Text(
                        'Score',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${Score.computerScore}',
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      )
                    ]),
              ),
              const SizedBox(
                height: 25,
              ),
              Flexible(
                child: StepProgressIndicator(
                  totalSteps: 5,
                  currentStep: matchNumber,
                  size: 20,
                  selectedColor: Colors.amber,
                  unselectedColor: Colors.black,
                  roundedEdges: const Radius.circular(10),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Player1',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          InkWell(
                              onTap: onTapEnabled
                                  ? () async {
                                      onTabStatusChange();
                                      opacityChange(Choice.rock);
                                      playComputer(Choice.rock);
                                      await Future.delayed(
                                          const Duration(milliseconds: 1500));
                                      resetSettings();
                                      onTabStatusChange();
                                    }
                                  : null,
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 500),
                                opacity: rockOpacity,
                                child: CircleAvatar(
                                  radius: playerIndex == 0 ? 56 : 50,
                                  backgroundColor: rockBorder
                                      ? Colors.green
                                      : rockBorderComputer
                                          ? Colors.red
                                          : null,
                                  child: const GameButton(choice: Choice.rock,)
                                ),
                              )),
                          const SizedBox(
                            height: 30,
                          ),
                          InkWell(
                              onTap: onTapEnabled
                                  ? () async {
                                      onTabStatusChange();
                                      opacityChange(Choice.paper);
                                      playComputer(Choice.paper);
                                      await Future.delayed(
                                          const Duration(milliseconds: 1500));
                                      resetSettings();
                                      onTabStatusChange();
                                    }
                                  : null,
                              child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: paperOpacity,
                                  child: CircleAvatar(
                                    radius: playerIndex == 1 ? 56 : 50,
                                    backgroundColor: paperBorder
                                        ? Colors.green
                                        : paperBorderComputer
                                            ? Colors.red
                                            : null,
                                    child: const GameButton(choice: Choice.paper,)
                                  ))),
                          const SizedBox(
                            height: 30,
                          ),
                          InkWell(
                              onTap: onTapEnabled
                                  ? () async {
                                      onTabStatusChange();
                                      opacityChange(Choice.scissors);
                                      playComputer(Choice.scissors);
                                      await Future.delayed(
                                          const Duration(milliseconds: 1500));
                                      resetSettings();
                                      onTabStatusChange();
                                    }
                                  : null,
                              child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: scissorsOpacity,
                                  child: CircleAvatar(
                                    radius: playerIndex == 2 ? 56 : 50,
                                    backgroundColor: scissorsBorder
                                        ? Colors.green
                                        : scissorsBorderComputer
                                            ? Colors.red
                                            : null,
                                    child: const GameButton(choice: Choice.scissors,)
                                  ))),
                        ],
                      ),
                      const VerticalDivider(
                        color: Colors.purple,
                        thickness: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Computer',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          AnimatedOpacity(
                            opacity: computerRockOpacity,
                            duration: const Duration(milliseconds: 500),
                            child: CircleAvatar(
                              radius: computerIndex == 0 ? 56 : 50,
                              backgroundColor: scissorsBorderComputer
                                  ? Colors.green
                                  : paperBorder
                                      ? Colors.red
                                      : null,
                              child: const GameButton(choice: Choice.rock,)
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          AnimatedOpacity(
                            opacity: computerPaperOpacity,
                            duration: const Duration(milliseconds: 500),
                            child: CircleAvatar(
                                radius: computerIndex == 1 ? 56 : 50,
                                backgroundColor: rockBorderComputer
                                    ? Colors.green
                                    : scissorsBorder
                                        ? Colors.red
                                        : null,
                                child: const GameButton(choice: Choice.paper,)),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: computerScissorsOpacity,
                              child: CircleAvatar(
                                  radius: computerIndex == 2 ? 56 : 50,
                                  backgroundColor: paperBorderComputer
                                      ? Colors.green
                                      : rockBorder
                                          ? Colors.red
                                          : null,
                                  child: const GameButton(choice: Choice.scissors,))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: playAgainButtonOpacity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      primary: Colors.red,
                      onPrimary: Colors.white,
                      minimumSize: const Size(320, 60),
                    ),
                    onPressed: () => resetUi(),
                    child: const Text('Play Again!')),
              )
            ],
          ),
        ),
      ),
    );
  }
}


enum Choice {
  rock,
  paper,
  scissors;
}

extension ImagePathExtension on Choice {
  String path() {
    return 'assets/images/$name.png';
  }
}
