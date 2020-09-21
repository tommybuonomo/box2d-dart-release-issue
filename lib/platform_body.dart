import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';

class PlatformBody extends BodyComponent {
  PlatformBody(Box2DComponent box) : super(box) {
    _createBody(Vector2(0, -20));
  }

  void _createBody(Vector2 position) {
    final PolygonShape shape = PolygonShape();
    shape.setAsBox(box.viewport.width / 2, 2, position, 0);

    final fixtureDef = FixtureDef();
    // To be able to determine object in collision
    fixtureDef.shape = shape;
    fixtureDef.restitution = 0.5;
    fixtureDef.friction = 0.1;

    final bodyDef = BodyDef();
    bodyDef.position = position;
    bodyDef.type = BodyType.STATIC;

    body = world.createBody(bodyDef)..createFixtureFromFixtureDef(fixtureDef);
  }
}
