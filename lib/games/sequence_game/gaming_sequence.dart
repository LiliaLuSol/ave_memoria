import 'dart:async';
import 'package:flutter/material.dart';

class SequenceGame extends StatefulWidget {
  const SequenceGame({super.key});
  @override
  _SequenceGameState createState() => _SequenceGameState();
}

class _SequenceGameState extends State<SequenceGame> {
  List<int> sequence = [];
  int currentIndex = 0;
  bool canPlay = false;
  int roundTime = 5;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startRound();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startRound() {
    setState(() {
      sequence.clear();
      currentIndex = 0;
      canPlay = false;
    });

    // Generate new sequence
    generateSequence();

    // Start timer
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (roundTime == 0) {
        timer.cancel();
        setState(() {
          canPlay = true;
        });
      } else {
        setState(() {
          roundTime--;
        });
      }
    });

    // Reset round time
    roundTime += 5;
  }

  void generateSequence() {
    for (int i = 0; i < sequence.length + 1; i++) {
      sequence.add(i);
    }
    sequence.shuffle();
  }

  void checkSequence(int index) {
    if (index == sequence[currentIndex]) {
      if (currentIndex == sequence.length - 1) {
        // Player completed the round
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Round completed!'),
        ));
        startRound();
      } else {
        setState(() {
          currentIndex++;
        });
      }
    } else {
      // Player made a mistake
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Wrong sequence!'),
      ));
      startRound();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Game'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Show sequence
          Text(
            'Memorize the sequence:',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.center,
            children: sequence.map((index) {
              return GestureDetector(
                onTap: () {
                  if (!canPlay) return;
                  checkSequence(index);
                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  width: 50,
                  height: 50,
                  color: Colors.blueAccent,
                  child: Center(
                    child: Text(
                      index.toString(),
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          // Show timer
          Text(
            'Time left: $roundTime seconds',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
