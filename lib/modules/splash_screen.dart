import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:news_app/layout/news_layout.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    Timer(
        Duration(seconds: 4),
        () => SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => NewsScreen()));
            }));

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              child: DefaultTextStyle(
                style: TextStyle(
                    fontSize: width * 0.15,
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold),
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText('News For'),
                  ],
                  repeatForever: true,
                ),
              ),
            ),
          ),
          SizedBox(
            width: width,
            child: Center(
              child: TextLiquidFill(
                loadDuration: Duration(milliseconds: 2300),
                text: 'you',
                waveColor: Colors.greenAccent,
                boxBackgroundColor: Colors.deepPurple,
                textStyle: TextStyle(
                  fontSize: width * 0.2,
                  fontWeight: FontWeight.bold,
                ),
                boxHeight: height * 0.3,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.greenAccent,
          child: Text(
            'Skip',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.deepPurple),
          ),
          onPressed: () {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => NewsScreen()));
            });
          }),
    );
  }
}
