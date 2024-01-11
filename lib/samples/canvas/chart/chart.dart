import 'dart:math';

import 'package:flutter/material.dart';
import 'weekly_chart.dart';

var rng = Random();
List<int> dummyData() {
  List<int> data = [];
  for (var i = 0; i < 10; i++) {
    data.add(rng.nextInt(15));
  }
  return data;
}

class Chart extends StatelessWidget {
  const Chart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chart"), centerTitle: true),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            child: Container(
              height: 232,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(180),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                border: Border.all(color: Colors.white.withAlpha(40)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withAlpha(28),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ],
              ),
              // child: WeeklyChart(data: dummyData()),
              child: WeeklyChart(data: dummyData()),
            ),
          ),
        ],
      ),
    );
  }
}
