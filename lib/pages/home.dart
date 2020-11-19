
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var player = AudioCache();
  Map<String, bool> score = {};
  Map<String, Color> choices = {
    '🍎': Colors.red,
    '🥒': Colors.green,
    '🔵': Colors.blue,
    '🍋': Colors.yellow,
    '🍊': Colors.orange,
    '🍇': Colors.purple,
    '👜': Colors.brown,
  };
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              score.clear();
              index++;
            });
          }),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('your scores'),
      ),
      body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: choices.keys.map((element) {
                  return Expanded(
                      child: Draggable<String>(
                        data: element,
                        child: movable(score[element]==true ? 'thfgh' :
                        element),
                        feedback: movable(element),
                        childWhenDragging: movable('🐇'),
                      ),
                  );
                }).toList()
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: choices.keys.map((element) {
                return buildtarget(element);
              }).toList()..shuffle(Random(index)),
            )
          ],
        ),
    );
  }

  Widget buildtarget(element) {
    return DragTarget<String>(
      builder: (context, incoming, rejected) {
        if (score[element] == true) {
          return Container(
            color: Colors.white,
            child: Text('congratulations!'),
            alignment: Alignment.center,
            height: 80,
            width: 200,
          );
        }
        else {
          return Container(
            color: choices[element],
            height: 80,
            width: 200,
          );
        }
      },
      onWillAccept: (data) => data == element,
      onAccept: (data) {
        setState(() {
          score[element] == true;
          player.play('clap.mp3');
        });
      },
      onLeave: (data) {},
    );
  }
}
class movable extends StatelessWidget {
  final String emoji;
  movable(this.emoji);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        padding: EdgeInsets.all(0),
        child: Text(
          emoji,
          style: TextStyle(
              fontSize: 50,
              color: Colors.black,
          ),
        ),
      )
    );
  }
}

