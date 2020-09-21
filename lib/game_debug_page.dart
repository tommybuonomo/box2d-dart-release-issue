import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

import 'box2d_world.dart';
import 'game_debug.dart';

class GameDebugPage extends StatefulWidget {
  static const ROUTE = "/game_debug";

  GameDebugPage();

  @override
  _GameDebugPageState createState() => _GameDebugPageState();
}

class _GameDebugPageState extends State<GameDebugPage> with TickerProviderStateMixin, WidgetsBindingObserver {
  GameDebug _gameDebug;
  Widget _gameWidget;

  @override
  void initState() {
    Wakelock.enable();
    _gameDebug = GameDebug(context, Box2DWorld());
    _gameWidget = _gameDebug.widget;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildGame();
  }

  Widget _buildGame() {
    return Container(
        child: Stack(
      children: <Widget>[
        _gameWidget,
      ],
    ));
  }
}
