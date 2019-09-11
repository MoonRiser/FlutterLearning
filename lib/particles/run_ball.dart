import 'dart:math';
import 'package:flutter/material.dart';

import '../styles.dart';
import 'ball.dart';
import 'float_ball.dart';

class RunBall extends StatefulWidget {
  @override
  _RunBallState createState() => _RunBallState();
}

class _RunBallState extends State<RunBall> with TickerProviderStateMixin {
  AnimationController controller;
  AnimationController controllerG; //控制粒子贝塞尔轨迹
  Animation animation;

  // var _oldTime = DateTime.now().millisecondsSinceEpoch;
  var _area = Rect.fromLTRB(0 + 20.0, 0, 370 + 20.0, 0 + 200.0);
  var _areaF = Rect.fromLTRB(0 + 20.0, 0, 370 + 20.0, 0 + 200.0);

  var _balls = <Ball>[];
  var _ballsF = <Ball>[];

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
        Container(
          child: Text("粒子碰撞"),
          height: 20,
        ),
        GestureDetector(
          child: Container(
            width: double.infinity,
            height: 200,
            child: CustomPaint(
              painter: FloatBallView(_ballsF, _areaF),
            ),
          ),
          onTap: () {
            controllerG.forward();
          },
          onDoubleTap: () {
            controllerG.stop();
          },
        ),
        Container(
          child: Text("粒子漂浮"),
          height: 20,
        ),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: testFields,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(days: 365 * 999),
    )..addListener(() {
        _render();
      });

    controllerG = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..addListener(() {
        _renderBezier();
      });
    animation = CurvedAnimation(parent: controllerG, curve: Curves.linear);
    animation.addStatusListener((status) {
      switch(status){
        case AnimationStatus.dismissed:
          controllerG.forward();
          // TODO: Handle this case.
          break;
        case AnimationStatus.forward:
          // TODO: Handle this case.
          break;
        case AnimationStatus.reverse:
          // TODO: Handle this case.
          break;
        case AnimationStatus.completed:
          // TODO: Handle this case.
        controllerG.reverse();
          break;
      }
    });

    for (var i = 0; i < 100; i++) {
      var random = new Random();
      _balls.add(new Ball(
          color: Styles.randomColor(),
          r: 16,
          aY: 0.05,
          vX: random.nextInt(4).toDouble(),
          vY: -random.nextInt(4).toDouble(),
          x: _randPosition().dx,
          y: _randPosition().dy));
    }

    for (var i = 0; i < 10; i++) {
      var random = new Random();
      _ballsF.add(new Ball(
          color: Colors.blue,
          r: 8,
          aY: 0.05,
          vX: random.nextInt(4).toDouble(),
          vY: -random.nextInt(4).toDouble(),
          x: _randPosition().dx,
          y: _randPosition().dy));
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    controllerG.dispose();
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

  _renderBezier() {
    setState(() {
      _ballsF.forEach((ball) {
        bezierPath(ball, animation.value);
      });
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

    var temp = ball.r / 2;
    if (temp < 1) {
      ball.r = 16;
      var offset = _randPosition();
      ball.x = offset.dx;
      ball.y = offset.dy;
    } else {
      ball.r = temp;
    }
  }

//碰撞后随机色
  void _randColor(Ball ball) {
    ball.color = Styles.randomColor(); //碰撞后随机色
  }

  //随机生成圆心坐标
  Offset _randPosition([int seed]) {
    var random;
    if (seed != null) {
      random = new Random(seed);
    } else {
      random = new Random();
    }

    var x = 36 + random.nextInt(339);
    var y = 16 + random.nextInt(169);
    return Offset(x.toDouble(), y.toDouble());
  }

  //贝塞尔曲线路径
  void bezierPath(Ball ball, double t) {
    //(1-t)*(1-t)*p0 +2*t*(1-t)*p1+t*t*p2

    Offset p0 = Offset(ball.x, ball.y);
    Offset p1 = _randPosition(ball.id);

    Offset p2 = _randPosition(ball.id + 1);
    var bx =
        (1 - t) * (1 - t) * p0.dx + 2 * t * (1 - t) * p1.dx + t * t * p2.dx;
    var by =
        (1 - t) * (1 - t) * p0.dy + 2 * t * (1 - t) * p1.dy + t * t * p2.dy;
    ball.x = bx;
    ball.y = by;
  }
}
