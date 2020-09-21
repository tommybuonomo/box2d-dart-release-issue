import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';

enum Side { TOP, BOTTOM, RIGHT, LEFT }

class WallBody extends BodyComponent {
  Side side;

  WallBody(Box2DComponent box, this.side) : super(box) {
    _createBody();
  }

  void _createBody() {
    final PolygonShape shape = PolygonShape();

    var position = Vector2.zero();
    switch (side) {
      case Side.LEFT:
        position = Vector2(-box.viewport.width / 4, 0);
        shape.setAsBox(2, box.viewport.height, position, 0);
        break;
      case Side.TOP:
        position = Vector2(0, box.viewport.height / 4);
        shape.setAsBox(box.viewport.width, 2, position, 0);
        break;
        break;
      case Side.BOTTOM:
        position = Vector2(0, -box.viewport.height / 4);
        shape.setAsBox(box.viewport.width / 2, 2, position, 0);
        break;
        break;
      case Side.RIGHT:
        position = Vector2(box.viewport.width / 4, 0);
        shape.setAsBox(2, box.viewport.height, position, 0);
        break;
    }

    final fixtureDef = FixtureDef();
    // To be able to determine object in collision
    fixtureDef.shape = shape;
    fixtureDef.restitution = 0.5;
    fixtureDef.friction = 0;

    final bodyDef = BodyDef();
    bodyDef.position = position;
    bodyDef.type = BodyType.STATIC;

    body = world.createBody(bodyDef)..createFixtureFromFixtureDef(fixtureDef);
  }
}
