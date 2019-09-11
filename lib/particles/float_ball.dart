import 'ball.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';


class FloatBallView extends RunBallView {
  FloatBallView(List<Ball> balls, Rect area) : super(balls, area);

  @override
  void paint(Canvas canvas, Size size) {
    super.drawLineBetweenAnyBalls(canvas);
    super.paint(canvas, size);


  }


}

