import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rockpaperscissors_app/feature/game/view/game_view.dart';
import 'package:rockpaperscissors_app/feature/home/view/home_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'RockPaperScissorsApp',
      
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
