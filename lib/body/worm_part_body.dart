import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:releasemodebug/body/worm_body_group.dart';

class WormPartBody extends BodyComponent {
  double width;
  double height;
  WormBodyGroup parent;
  bool bug = false;

  @override
  int priority() {
    return 5;
  }

  WormPartBody(Box2DComponent box, Vector2 position, double size, this.parent) : super(box) {
    _createBody(size, position);
  }

  void _createBody(double size, Vector2 position) {
    final CircleShape shape = CircleShape();
    shape.radius = size;
    width = size * 2;
    height = size * 2;

    final fixtureDef = FixtureDef();
    fixtureDef.shape = shape;
    fixtureDef.restitution = 0.9;
    fixtureDef.density = 0.03;
    fixtureDef.friction = 0.2;

    final bodyDef = BodyDef();
    bodyDef.position = position;
    bodyDef.type = BodyType.DYNAMIC;

    body = world.createBody(bodyDef)..createFixtureFromFixtureDef(fixtureDef);
  }

  var _paint = Paint();

  @override
  void renderCircle(Canvas canvas, Offset center, double radius) {
    _paint.color = bug ? Color.fromARGB(255, 0, 0, 0) : Color.fromARGB(255, 255, 255, 255);
    canvas.drawCircle(center, radius, _paint);
  }
}
