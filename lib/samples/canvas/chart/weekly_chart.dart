import 'dart:async';

import 'package:flutter/material.dart';

import 'my_canvas.dart';

class WeeklyChart extends StatefulWidget {
  final List<int> data;
  const WeeklyChart({required this.data, super.key});

  @override
  State<WeeklyChart> createState() => _WeeklyChartState();
}

class _WeeklyChartState extends State<WeeklyChart> {
  late List<int> weekData;
  late Timer timer;
  int minD = double.maxFinite.toInt();
  int maxD = -double.maxFinite.toInt();
  int rangeD = 1;
  double percentage = 0.0;
  @override
  void initState() {
    super.initState();
    setState(() {
      weekData = widget.data.take(7).toList();
      for (var d in weekData) {
        minD = d < minD ? d : minD;
        maxD = d > maxD ? d : maxD;
      }
      rangeD = maxD - minD;
    });

    // setup animation timer and update variable
    const fps = 50.0;
    const totalAnimDuration = 1.0; // animate for x seconds
    var percentStep = 1.0 / (totalAnimDuration * fps);
    var frameDuration = (1000 ~/ fps);
    timer = Timer.periodic(Duration(milliseconds: frameDuration), (timer) {
      setState(() {
        percentage += percentStep;
        percentage = percentage > 1.0 ? 1.0 : percentage;
        if (percentage >= 1.0) {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyCanvas(weekData, minD, maxD, rangeD, percentage),
      child: Container(),
    );
  }
}
