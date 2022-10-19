import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rockpaperscissors_app/feature/game/view/game_view.dart';
import 'package:rockpaperscissors_app/feature/game/view/widgets/game_button_widget.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFCFDFFF),
        appBar: AppBar(
          title: Center(
            child: SizedBox(
                child: Text(
              'Rock Paper Scissors\nPlay!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.purple, fontSize: 25),
            )),
          ),
          elevation: 0,
          backgroundColor: Color(0xFFCFDFFF),
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: Column(children: [
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              GameButton(choice: Choice.rock),
              GameButton(choice: Choice.paper),
              GameButton(choice: Choice.scissors)
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Center(
              child: Text('Please select game mode',
                  style: TextStyle(fontSize: 24))),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                primary: Colors.red,
                onPrimary: Colors.white,
                minimumSize: Size(320, 60),
              ),
              onPressed: () {
                Get.to(() => GamePage(),transition: Transition.circularReveal,duration: Duration(milliseconds: 2500));
              },
              child: Text('SinglePlayer'))
        ]));
  }
}
