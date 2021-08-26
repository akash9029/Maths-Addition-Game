import 'dart:math';
import 'dart:ui';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'splashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maths Game',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: SplashScreenHome(),
    );
  }
}

class MathsGame extends StatefulWidget {
  const MathsGame({Key? key}) : super(key: key);

  @override
  _MathsGameState createState() => _MathsGameState();
}

class _MathsGameState extends State<MathsGame> {
  int randomNo1 = Random().nextInt(100);
  int randomNo2 = Random().nextInt(100);
  int randomNo3 = Random().nextInt(100);
  bool boole = Random().nextBool();
  int turnLeft = 3;
  late int result;
  int score = 0;
  CountDownController _controller = CountDownController();

  @override
  void initState() {
    super.initState();
    (boole) ? result = randomNo1 + randomNo2 : result = randomNo3;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orange[100],
        body: Center(
            child: (turnLeft == 0) ? gameOverContainer() : gamePlayContainer()),
      ),
    );
  }

  createRandomNumber() {
    randomNo1 = Random().nextInt(100);
    randomNo2 = Random().nextInt(100);
    randomNo3 = Random().nextInt(100);
    boole = Random().nextBool();
    (boole) ? result = randomNo1 + randomNo2 : randomNo3 = randomNo3;
  }

  Widget timer() {
    return CircularCountDownTimer(
      controller: _controller,
      isReverse: true,
      strokeWidth: 8,
      width: 40,
      height: 40,
      duration: 15,
      fillColor: Colors.grey,
      ringColor: Colors.blue,
      onComplete: () {
        setState(() {
          turnLeft--;
          _controller.start();
          createRandomNumber();
        });
      },
    );
  }

  Widget gamePlayContainer() {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: double.infinity,
        child: Image(
          fit: BoxFit.cover,
          image: AssetImage("assets/background.jpg"),
        ),
      ),
      Center(
        child: Container(
          width: 300,
          height: 400,
          color: Colors.black,
          child: Card(
            color: Colors.grey[50],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20),
                    child: timer()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        "Score : $score",
                        style: TextStyle(color: Colors.green, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        "Turn Left : $turnLeft",
                        style: TextStyle(fontSize: 15, color: Colors.red),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "$randomNo1",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange),
                      ),
                      Text(
                        "+",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange),
                      ),
                      Text(
                        "$randomNo2",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange),
                      ),
                      Text(
                        "=",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 120),
                  child: Text(
                    (boole) ? "$result" : "$randomNo3",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10)),
                        onPressed: () {
                          if (randomNo1 + randomNo2 == result) {
                            setState(() {
                              score++;
                            });
                          } else {
                            setState(() {
                              turnLeft--;
                            });
                          }
                          _controller.start();
                          createRandomNumber();
                        },
                        child: Icon(Icons.check),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        ),
                        onPressed: () {
                          if (randomNo1 + randomNo2 != result) {
                            setState(() {
                              score++;
                            });
                          } else {
                            setState(() {
                              turnLeft--;
                            });
                          }
                          _controller.start();
                          createRandomNumber();
                        },
                        child: Icon(Icons.cancel),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 80),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        turnLeft = 3;
                        score = 0;
                        _controller.start();
                        createRandomNumber();
                      });
                    },
                    child: Text(
                      "Restart Game",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  Widget gameOverContainer() {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: double.infinity,
        child: Image(
          fit: BoxFit.cover,
          image: AssetImage("assets/background.jpg"),
        ),
      ),
      Center(
        child: Container(
          color: Colors.black,
          width: 300,
          height: 400,
          child: Card(
            color: Colors.grey[50],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  " Game Over !!",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10)),
                  onPressed: () {
                    setState(() {
                      turnLeft = 3;
                      score = 0;
                      createRandomNumber();
                    });
                  },
                  icon: Icon(
                    Icons.restart_alt,
                  ),
                  label: Text(
                    "Play Again",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ),
    ]);
  }
}
