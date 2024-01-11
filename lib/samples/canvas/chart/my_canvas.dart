import 'package:flutter/material.dart';

class ChartGrid {
  final Paint linePaint;
  final List<double> xCoords;
  final List<double> yCoords;
  final List<int> yCoordsData;
  final double yUnitH;
  final Rect rect;
  const ChartGrid({
    required this.xCoords,
    required this.yCoords,
    required this.yCoordsData,
    required this.yUnitH,
    required this.rect,
    required this.linePaint,
  });

  factory ChartGrid.fromSize(Size size, int max) {
    var linePaint = Paint()
      ..color = Colors.grey.withAlpha(80)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    var rect = Rect.fromPoints(
      const Offset(20, 0),
      Offset(size.width, size.height - 20),
    );

    List<double> xCoords = [];
    var colW = rect.width / 6.0;
    var x = rect.left;
    for (var i = 0; i <= 6; i++) {
      xCoords.add(x);
      x += colW;
    }

    var yUnitH = rect.height / max;
    var yDataH = (max / 4).floor();
    List<int> yCoordsData = [0];
    var yData = 0;
    while (yData < max) {
      yData += yDataH;
      if (yData > max) {
        yData = max;
      }
      yCoordsData.add(yData);
    }
    List<double> yCoords = [];
    for (var yc in yCoordsData) {
      var coord = rect.bottom - (yc * yUnitH);
      if (coord < rect.top) {
        coord = rect.top;
      }
      yCoords.add(coord);
    }
    return ChartGrid(
      xCoords: xCoords,
      yCoords: yCoords,
      yCoordsData: yCoordsData,
      yUnitH: yUnitH,
      rect: rect,
      linePaint: linePaint,
    );
  }
}

class MyCanvas extends CustomPainter {
  final List<int> weekData;
  final int minD;
  final int maxD;
  final int rangeD;
  final double percentage;
  final bgLineColor = Colors.grey.withAlpha(80);
  MyCanvas(this.weekData, this.minD, this.maxD, this.rangeD, this.percentage);

  @override
  bool shouldRepaint(covariant MyCanvas oldDelegate) {
    return percentage != oldDelegate.percentage;
  }

  @override
  void paint(Canvas canvas, Size size) {
    print("Drawing: $weekData");
    var grid = ChartGrid.fromSize(size, maxD);

    drawGrid(canvas, grid);
    drawDataPoints(canvas, grid);
    drawLabels(canvas, grid);
  }

  var chartW = 300.0;
  var chartH = 100.0;
  var W = 350.0;

  void drawGrid(Canvas canvas, ChartGrid grid) {
    for (final x in grid.xCoords) {
      final p1 = Offset(x, grid.rect.bottom);
      final p2 = Offset(x, grid.rect.top);
      canvas.drawLine(p1, p2, grid.linePaint);
    }
    for (final y in grid.yCoords) {
      final p1 = Offset(grid.rect.left, y);
      final p2 = Offset(grid.rect.right, y);
      canvas.drawLine(p1, p2, grid.linePaint);
    }
  }

  void drawDataPoints(Canvas canvas, ChartGrid grid) {
    var paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;
    var p = Path();
    for (var i = 0; i < weekData.length; i++) {
      final d = weekData[i];
      var y = d * grid.yUnitH * percentage;
      if (i == 0) {
        p.moveTo(grid.xCoords[i], grid.rect.bottom - y);
      } else {
        p.lineTo(grid.xCoords[i], grid.rect.bottom - y);
      }
    }
    canvas.drawPath(p, paint);
  }

  void drawLabels(Canvas canvas, ChartGrid grid) {
    var style = const TextStyle(
      color: Colors.white,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );
    final xLabel = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    for (var i = 0; i < 7; i++) {
      final painter = TextPainter(
        text: TextSpan(text: xLabel[i], style: style),
        textDirection: TextDirection.ltr,
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(grid.xCoords[i] - painter.width / 2, grid.rect.bottom + 8),
      );
    }

    for (var i = 0; i < grid.yCoords.length; i++) {
      final painter = TextPainter(
        text: TextSpan(text: "${grid.yCoordsData[i]}", style: style),
        textDirection: TextDirection.ltr,
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(
          grid.rect.left - painter.width - 10,
          grid.yCoords[i] - painter.height / 2,
        ),
      );
    }

    //draw y Label
    // drawText(canvas, rect.bottomLeft + const Offset(-35, -10), 40, labelStyle, minD.toStringAsFixed(1)); // print min value
    // drawText(canvas, rect.topLeft + const Offset(-35, 0), 40, labelStyle, maxD.toStringAsFixed(1)); // print max value
  }
}
