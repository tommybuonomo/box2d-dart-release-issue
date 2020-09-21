import 'package:flame/box2d/box2d_component.dart';

class Box2DWorld extends Box2DComponent {
  static const WORLD_SCALE = 20.0;

  Box2DWorld()
      : super(
            scale: WORLD_SCALE,
            gravity: -24,
            velocityIterations: 20,
            positionIterations: 10,
            worldPoolSize: 150,
            worldPoolContainerSize: 20) {
    world.setAllowSleep(false);
  }

  @override
  void initializeWorld() {
    // Empty, this method is never called
  }
}
