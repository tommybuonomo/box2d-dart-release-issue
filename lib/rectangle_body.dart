import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/material.dart';

class RectangleBody extends BodyComponent {
  double width;
  double height;
  bool draw;
  int drawPriority;
  Paint _paint;

  @override
  int priority() => drawPriority;

  RectangleBody(Box2DComponent box, Vector2 position, this.width, this.height,
      {BodyType bodyType = BodyType.STATIC,
      bool hasCollision = true,
      Vector2 shapePosition,
      double angle = 0,
      String constantId,
      this.draw = true,
      this.drawPriority = 0})
      : super(box) {
    _createBody(position, bodyType, hasCollision, shapePosition ?? Vector2.zero(), angle, constantId);
    _paint = Paint()
      ..isAntiAlias
      ..filterQuality = FilterQuality.high;
  }

  void _createBody(
      Vector2 position, BodyType bodyType, bool hasCollision, Vector2 shapePosition, double angle, String constantId) {
    final PolygonShape shape = PolygonShape();
    var realPosition = Vector2.copy(position);
    shape.setAsBox(width / 2, height / 2, Vector2(shapePosition.x * width, shapePosition.y * height), 0);

    final fixtureDef = FixtureDef();
    // To be able to determine object in collision
    fixtureDef.shape = shape;
    fixtureDef.restitution = 0.5;
    fixtureDef.friction = 0.5;
    fixtureDef.density = 1.0;
    fixtureDef.isSensor = !hasCollision;

    final bodyDef = BodyDef();
    bodyDef.position = realPosition;
    bodyDef.type = bodyType;
    bodyDef.angle = angle;

    body = world.createBody(bodyDef)..createFixtureFromFixtureDef(fixtureDef);
  }

  @override
  void renderPolygon(Canvas canvas, List<Offset> points) {
    if (!draw) {
      return;
    }
    final path = Path()..addPolygon(points, true);
    canvas.drawPath(path, _paint);
  }
}
