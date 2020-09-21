import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackgroundBody extends BodyComponent {
  Paint _paint = Paint();
  BuildContext context;
  Rect _screenRect;

  BackgroundBody(Box2DComponent box, this.context) : super(box) {
    _createBody();
    _screenRect = Rect.fromLTWH(0, 0, 1000, 1000);
  }

  void _createBody() {
    final PolygonShape shape = PolygonShape();
    shape.setAsBox(box.viewport.width / 2, box.viewport.height / 2, Vector2.zero(), 0);

    final fixtureDef = FixtureDef();
    // To be able to determine object in collision
//    fixtureDef.setUserData(this);
    fixtureDef.shape = shape;
    fixtureDef.restitution = 0.0;
    fixtureDef.density = 1.0;
    fixtureDef.friction = 0.1;
    fixtureDef.isSensor = true;

    final bodyDef = BodyDef();
    bodyDef.position = Vector2.zero();
    bodyDef.type = BodyType.KINEMATIC;

    body = world.createBody(bodyDef)..createFixtureFromFixtureDef(fixtureDef);
  }

  @override
  void renderPolygon(Canvas canvas, List<Offset> points) {
    _paint.color = Colors.deepOrangeAccent;
    canvas.drawRect(_screenRect, _paint);
    var rect = Rect.fromCircle(
      center: Offset(100, 100),
      radius: 100,
    );
    _paint.shader = RadialGradient(colors: [
      Colors.deepOrangeAccent,
      Colors.deepOrangeAccent,
    ]).createShader(rect);
    canvas.drawRect(rect, _paint);
  }
}
