
import 'dart:async';
import 'package:flippybird/barriers.dart';
import 'package:flippybird/bird.dart';
import 'package:flutter/material.dart';
import 'barrierstwo.dart';

class Home extends StatefulWidget{
  const Home({super.key});

  @override
  State<StatefulWidget> createState() =>HomeState();
}

class HomeState extends State<Home>{

  static double birdYaxis= 0 ;
  double time = 0;
  double height = 0;
  late int score = 0;
  late int best = 0;
  double initialHeight = birdYaxis;
  bool gameStart = false;
  static double barrierX1 = 2;
  static double barrierX2 = barrierX1 + 1.5;
  static double barrierX3 = barrierX2 +1.6 ;
  double barrierX4 = barrierX3 +1.9 ;


  void jump(){
   setState(() {
     time = 0;
     score+=1;
     initialHeight = birdYaxis;
   });
   if (score>=best){
     best = score;
   }
  }


  bool birdisDead(){
        if(birdYaxis > 1 || birdYaxis < -1){
          return true;
        }
        return false;
    }

  void startGame(){
    score=0;
    gameStart = true;
    Timer.periodic(const Duration(milliseconds: 45) , (timer){

      time+= 0.04;
      height = -4.86 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;

        setState(() {
          if(barrierX1 < -1.5){
            barrierX1 += 2.3;
          } else {
            barrierX1 -=0.05;
          }
        });

        if(birdisDead()){
          timer.cancel();
          _showDialog();
        }


        setState(() {
          if(barrierX2 < -1.5){
            barrierX2 += 2.3;
          } else {
            barrierX2 -=0.05;
          }
        });

         setState(() {
          if(barrierX3 < -1.5){
            barrierX3 += 2.3;
          } else {
            barrierX3 -=0.05;
          }
        });
      setState(() {
          if(barrierX4 < -1.5){
            barrierX4 += 2.3;
          } else {
            barrierX4 -=0.05;
          }
        });



      });

      if (birdYaxis > 1){
        timer.cancel();
        gameStart = false;
      }
    });
  }


  void resetGame(){
    Navigator.pop(context);
    setState(() {
      birdYaxis = 0;
      gameStart = false;
      time=0;
      initialHeight = birdYaxis;
    });
  }

  void _showDialog(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder:(context) {
          return AlertDialog(
            backgroundColor: Color(0x6d4d2a14),
            title: Center(child: Image.asset("lib/images/gmover.png" , width: 120, height: 120,)),
            actions: [GestureDetector(
              onTap: resetGame,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  padding: EdgeInsets.all(11),
                  color: Colors.white,
                  child: const Text("Start Again" , style: TextStyle( color: Colors.amber , fontSize: 16 , fontWeight: FontWeight.bold),),

                ),
              ),
            )],
          );
        }, );
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if (gameStart){
          jump();
        }else{
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 4,
                child: Stack(
                  children: [
                    Image.asset("lib/images/blue.jpg" , width: 700, height: 700, repeat: ImageRepeat.repeat),
                    AnimatedContainer(
                      alignment:  Alignment(0,birdYaxis),
                      duration: const Duration(milliseconds: 0),
                      color: const Color(0x6bf7eb),
                      child: Bird(),
                    ),
                    Container(
                      alignment: const Alignment(0,0.65),
                      child: gameStart ? const Text("") : Image.asset('lib/images/play.png' , height: 200 , width: 200,),
                    ),
                    AnimatedContainer(
                        duration: const Duration(milliseconds: 0),
                      alignment: Alignment(barrierX1,1.1),
                      child: Barrier(
                        size: 200.0,
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      alignment: Alignment(barrierX1,-1.3),
                      child: Barrier(
                        size: 220.0,
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      alignment: Alignment(barrierX2,1.2),
                      child: Barrier(
                        size: 180.0,
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      alignment: Alignment(barrierX2,-1.2),
                      child: Barrier(
                        size: 260.0,
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      alignment: Alignment(barrierX3,1.2),
                      child: Barrier(
                        size: 100.0,
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      alignment: Alignment(barrierX3,-1.2),
                      child: Barrier(
                        size: 300.0,
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      alignment: Alignment(barrierX4,1.2),
                      child: Barriertwo(
                        size: 170.0,
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      alignment: Alignment(barrierX4,-1.1),
                      child: Barriertwo(
                        size: 250.0,
                      ),
                    ),
                  ],
                ),
            ),
            Container(
              height: 10,
              color: Colors.green,

            ),
            Expanded(
                child: Container(
                  color: const Color(0xff6b492f),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Image.asset('lib/images/score.png' , height: 50, width: 50,),
                          const Text("Score" ,
                            style: TextStyle(color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),),
                          const SizedBox(height: 5,),
                           Text(score.toString(),
                            style: const TextStyle(color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),)
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Image.asset('lib/images/best.png' , height: 45, width: 48,),
                          const SizedBox(height: 2,),
                           Text("Best",
                            style: const TextStyle(color: Colors.amber,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),),
                          const SizedBox(height: 5,),
                           Text(best.toString(),
                            style: TextStyle(color: Colors.amber,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),)
                        ],
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}