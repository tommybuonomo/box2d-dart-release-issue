# Dart Compiler Release Issue

This package only suppose to generate a bug using flame that happens only in release mode.

### Context of the issue
The initial issue has been declared on the [flame repository](https://github.com/flame-engine/flame/issues/456) during the developement of a game.

## Getting Started

- Clone the project
- Launch the application (iOS or Android, no matter) in release mode.
- The bug will happen randomly, most of the time in less than 3 minutes. When the bug happens, I color the affected linked bodies in black. (the work is a group of 7 bodies linked by joints). Sometimes, even the static bodies (top, left, bottom and right walls) are randomly move and deleted from the world. The bug is not a code issue. Some variables into body.dart are randomly changed during the execution of the game
- Checkout to the `bug-fixed` branch. Now the bug is gone, and the ONLY difference between the 2 branches is [this commit](https://github.com/tommybuonomo/dart-release-compiler-issue/commit/95e0179312276fc8bb653a3c12114517e13b7dca) that only add a `print("This print just fix the issue")` into the `setAwake` method of the `body.dart` class. 

### Conclusion
The only explanation could be a compiler optimization issue in release mode that affects the `body.dart` method.
