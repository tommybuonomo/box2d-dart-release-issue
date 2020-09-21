import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:releasemodebug/body/worm_part_body.dart';

class WormBodyGroup {
  List<WormPartBody> bodies = List();
  int partCount = 7;
  double partSize;
  WormPartBody head;
  List<Joint> joints;

  BodyComponent get followComponent => bodies[0];

  WormBodyGroup(Box2DComponent box) {
    partSize = 0.3;
    var bodyA = WormPartBody(box, Vector2.zero(), partSize, this);
    head = bodyA;
    bodies.add(bodyA);

    joints = List();

    for (var i = 0; i < partCount; i++) {
      var bodyB = WormPartBody(box, Vector2(0, i * bodyA.width / 2), partSize, this);
      bodies.add(bodyB);

      double dampingRatio = 0.1;
      double frequencyHz = 10;

      var topJoint = box.world.createJoint(DistanceJointDef()
        ..bodyA = bodyA.body
        ..localAnchorA.setValues(0, -bodyA.height / 2)
        ..bodyB = bodyB.body
        ..localAnchorB.setValues(0, -bodyA.height / 2)
        ..length = bodyA.width / 2
        ..dampingRatio = dampingRatio
        ..frequencyHz = frequencyHz
        ..collideConnected = false);

      var centerJoint = box.world.createJoint(DistanceJointDef()
        ..bodyA = bodyA.body
        ..localAnchorA.setValues(0, 0)
        ..bodyB = bodyB.body
        ..localAnchorB.setValues(0, 0)
        ..length = bodyA.width / 2
        ..dampingRatio = dampingRatio
        ..frequencyHz = frequencyHz
        ..collideConnected = false);

      var bottomJoint = box.world.createJoint(DistanceJointDef()
        ..bodyA = bodyA.body
        ..localAnchorA.setValues(0, bodyA.height / 2)
        ..bodyB = bodyB.body
        ..localAnchorB.setValues(0, bodyB.height / 2)
        ..length = bodyA.width / 2
        ..dampingRatio = dampingRatio
        ..frequencyHz = frequencyHz
        ..collideConnected = false);
      joints.add(bottomJoint);
      joints.add(topJoint);
      joints.add(centerJoint);
      bodyA = bodyB;
    }
  }

  void addBodies() {
    bodies.reversed.forEach((element) {
      element.box.add(element);
    });
  }
}
