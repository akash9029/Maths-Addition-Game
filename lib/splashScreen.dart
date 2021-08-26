import 'package:Maths_game_/main.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreenHome extends StatefulWidget {
  const SplashScreenHome({Key? key}) : super(key: key);

  @override
  _SplashScreenHomeState createState() => _SplashScreenHomeState();
}

class _SplashScreenHomeState extends State<SplashScreenHome> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext ctx) => MathsGame()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Stack(children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/background1.png"),
                ),
              ),
              Center(
                child: Center(
                  child: Container(
                    width: 500,
                    height: 500,
                    child: Lottie.asset("assets/maths.zip"),
                  ),
                ),
              ),
            ]),
          ],
        ),
      )),
    );
  }
}
