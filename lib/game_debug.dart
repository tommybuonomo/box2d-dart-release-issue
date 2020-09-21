import 'dart:async' as async;
import 'dart:math';

import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'package:releasemodebug/platform_body.dart';
import 'package:releasemodebug/wall_body.dart';
import 'package:releasemodebug/worm_body_group.dart';
import 'package:releasemodebug/worm_part_body.dart';

import 'background_body.dart';
import 'box2d_world.dart';

class GameDebug extends Box2DGame with TapDetector {
  BuildContext context;

  Box2DWorld box;

  GameDebug(this.context, this.box) : super(box) {
    init();
  }

  Future<void> init() async {
    add(BackgroundBody(box, context));
    add(PlatformBody(box));
    add(WallBody(box, Side.LEFT));
    add(WallBody(box, Side.RIGHT));
    add(WallBody(box, Side.BOTTOM));
    add(WallBody(box, Side.TOP));

    async.Timer.periodic(Duration(milliseconds: 500), (timer) {
      var worm = WormBodyGroup(box);
      var velocityX = Random.secure().nextInt(1000) - 500.0;
      var velocityY = Random.secure().nextInt(1000) - 500.0;
      var velocity = Vector2(velocityX, velocityY);
      worm.bodies.forEach((element) {
        element.body.applyForceToCenter(velocity);
        element.body.applyAngularImpulse(2);
      });

      async.Future.delayed(Duration(seconds: 10), () {
        // If there is no bug, remove the body to free some bodies
        if (worm.bodies.any((element) => !element.bug)) {
          worm.bodies.forEach((b) {
            box.remove(b);
          });
        }
      });

      worm.addBodies();
    });
  }

  @override
  void onTapDown(TapDownDetails details) {
    print(details);
    box.components.forEach((element) {
      element.body.applyLinearImpulse(Vector2(0, 1000), Vector2.zero(), true);
    });
  }

  @override
  void update(double t) {
    super.update(t);
    box.components.forEach((element) {
      if (!element.body.isActive()) {
        print("BUG DETECTED: Body not active: ${element.body.getType()}");

        // Color the entire buggy worm to black
        if (element is WormPartBody) {
          element.parent.bodies.forEach((b) {
            b.bug = true;
          });
        }
      }
    });
  }
}
