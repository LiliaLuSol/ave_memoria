import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';
import 'package:flutter/cupertino.dart';

class NumberDisplay extends StatefulWidget {
  final List<int> sequence;
  final Map<int, String> numberImageMap;
  final Duration delay;
  final Function()? onSequenceDisplayed;

  const NumberDisplay({
    required this.sequence,
    required this.numberImageMap,
    required this.delay,
    this.onSequenceDisplayed,
    Key? key,
  }) : super(key: key);

  @override
  _NumberDisplayState createState() => _NumberDisplayState();
}

class _NumberDisplayState extends State<NumberDisplay> {
  int currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.delay, (timer) {
      if (currentIndex < widget.sequence.length) {
        setState(() {
          currentIndex++;
        });
      } else {
        timer.cancel();
        if (widget.onSequenceDisplayed != null) {
          widget.onSequenceDisplayed!();
        }
      }
    });

  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      currentIndex < widget.sequence.length
          ? widget.numberImageMap[widget.sequence[currentIndex]] ?? ''
          : '',
      style: CustomTextStyles.bold30Text
    );
  }
}