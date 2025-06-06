import 'package:flutter/material.dart';

const PURPLE = Color(0xff6432cd);
const ORANGE = Color(0xffe99f16); //ff prefix for alpha?

class Styling {
  static const accent = PURPLE;
  static const secondary = ORANGE;
  static const double barRadius = 8;
  static const double portraitHealthHeight = 300;
  static const double portraitHealthWidth = 20;

  Styling();

  static var styleA = ButtonStyle(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(width: 1, color: Colors.black),
      ),
    ),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered)) {
          return Colors.blue.withOpacity(0.04);
        }
        if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.pressed)) {
          return Colors.blue.withOpacity(0.12);
        }
        return null; // Defer to the widget's default.
      },
    ),
  );

  static var styleADisabled = ButtonStyle(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(width: 1, color: Colors.grey),
      ),
    ),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.grey),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered)) {
          return Colors.blue.withOpacity(0.04);
        }
        if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.pressed)) {
          return Colors.blue.withOpacity(0.12);
        }
        return null; // Defer to the widget's default.
      },
    ),
  );

  static ButtonStyle defaultButtonStyle() {
    return styleA;
  }

  static ButtonStyle defaultButtonStyleDisabled() {
    return styleADisabled;
  }
}
