import 'dart:math';
import 'package:flutter/material.dart';

import '../styles.dart';
import 'ball.dart';

class RunBall extends StatefulWidget {
  @override
  _RunBallState createState() => _RunBallState();
}

class _RunBallState extends State<RunBall> with TickerProviderStateMixin {
  AnimationController controller;

  // var _oldTime = DateTime.now().millisecondsSinceEpoch;
  var _area = Rect.fromLTRB(0 + 40.0, 0 + 200.0, 320 + 40.0, 200 + 200.0);

  var _balls = <Ball>[];

  @override
  Widget build(BuildContext context) {
//    var child = Scaffold(
//      body: CustomPaint(
//        painter: RunBallView(_balls, _area),
//      ),
//    );

    var testFields = Column(
      children: <Widget>[
        GestureDetector(
          child: Container(
            width: double.infinity,
            height: 200,
            child: CustomPaint(
              painter: RunBallView(_balls, _area),
            ),
          ),
          onTap: () {
            controller.forward();
          },
          onDoubleTap: () {
            controller.stop();
          },
        ),
        GestureDetector(
          child: Text('hello,world'),
        ),
      ],
    );

    return Scaffold(
      body: testFields,
    );
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(days: 365 * 999),
    )..addListener(() {
        _render();
      });

    for (var i = 0; i < 100; i++) {
      var random = new Random();
      _balls.add(new Ball(
          color: Styles.randomColor(),
          r: 16,
          aY: 0.05,
          vX: random.nextInt(4).toDouble(),
          vY: -random.nextInt(4).toDouble(),
          x: 80.0 + random.nextInt(6) * 20,
          y: 250.0 + random.nextInt(6) * 20));
    }
  }

  @override
  void dispose() {
    controller.dispose();
  }

  _render() {
    setState(() {
      _balls.forEach((ball) {
        updateBall(ball);
      });

      // var now = DateTime.now().millisecondsSinceEpoch;
      //  print("时间差/刷新周期：${now - _oldTime}ms");
    });
  }

  //[3].更新小球的信息
  void updateBall(Ball _ball) {
    //运动学公式
    _ball.x += _ball.vX;
    _ball.y += _ball.vY;
    _ball.vX += _ball.aX;
    _ball.vY += _ball.aY;
    //print('竖直方向上的加速度为：${_ball.aY}');
    //限定下边界
    if (_ball.y > _area.bottom - _ball.r) {
      //     _ball.y = _area.bottom - _ball.r;
      _ball.vY = -_ball.vY;
      _randColor(_ball);
      _halfRadius(_ball);
    }
    //限定上边界
    if (_ball.y < _area.top + _ball.r) {
      //     _ball.y = _area.top + _ball.r;
      _ball.vY = -_ball.vY;
      _randColor(_ball);
      _halfRadius(_ball);
    }

    //限定左边界
    if (_ball.x < _area.left + _ball.r) {
//      _ball.x = _area.left + _ball.r;
      _ball.vX = -_ball.vX;
      _randColor(_ball);
      _halfRadius(_ball);
    }

    //限定右边界
    if (_ball.x > _area.right - _ball.r) {
      //     _ball.x = _area.right - _ball.r;
      _ball.vX = -_ball.vX;
      _randColor(_ball);
      _halfRadius(_ball);
    }
  }

  //碰撞后小球半径减半
  void _halfRadius(Ball ball) {
    // print("小球半径为：${ball.r}");
    var random = new Random();
    var temp = ball.r / 2;
    if (temp < 1) {
      ball.r = 16;
      ball.x = 80.0 + random.nextInt(6) * 20;
      ball.y = 250.0 + random.nextInt(6) * 20;
    } else {
      ball.r = temp;
    }
  }

//碰撞后随机色
  void _randColor(Ball ball) {
    ball.color = Styles.randomColor(); //碰撞后随机色
  }
}
