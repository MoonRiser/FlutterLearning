import 'dart:math';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Ball {
  double aX;
  double aY;
  double vX;
  double vY;
  double x;
  double y;
  double r;
  Color color;
  static int _count = 0;
  int id;

  Ball(
      {this.aX = 0,
      this.aY = 0,
      this.vX = 0,
      this.vY = 0,
      this.x = 0,
      this.y = 0,
      this.r = 0,
      this.color}) {
    _count++;
    this.id = _count * 2;
  }
}

class RunBallView extends CustomPainter {
  //Ball _ball;
  List<Ball> _balls;
  Rect _area;
  Paint mPaint; //主画笔
  Paint bgPaint;

  RunBallView(this._balls, this._area) {
    mPaint = new Paint();
    bgPaint = new Paint()..color = Color.fromARGB(148, 198, 246, 248);
  } //背景画笔

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(_area, bgPaint);
    _balls.forEach((ball) {
      mPaint.color = ball.color;
      _drawBall(canvas, ball);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  _drawBall(Canvas canvas, Ball ball) {
    canvas.drawCircle(Offset(ball.x, ball.y), ball.r, mPaint);
  }

  void drawLineBetweenAnyBalls(Canvas canvas) {
    mPaint.style = PaintingStyle.stroke;
    mPaint.color = Colors.blue[400];
    mPaint.strokeWidth = 2;

    for (int i = 0; i < _balls.length; i++) {
      for (int k = i + 1; k < _balls.length; k++) {
        canvas.drawLine(Offset(_balls[i].x, _balls[i].y),
            Offset(_balls[k].x, _balls[k].y), mPaint);
      }
    }
    mPaint.style = PaintingStyle.fill;
  }
}
