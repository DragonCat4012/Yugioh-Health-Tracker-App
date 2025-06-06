import 'package:flutter/material.dart';

class LogEntry {
  int value = 0;
  int meHealth = 0;
  int enemyHealth = 0;
  bool isMe = true;
  Color color = const Color(0xffb74093);
  Color positiveColor = Colors.green;
  Color negativeColor = Colors.red;

  LogEntry(this.value, this.meHealth, this.enemyHealth, this.isMe) {
    color = value > 0 ? positiveColor : negativeColor;
  }

  String getMeText() {
    if (isMe) {
      if (value > 0) {
        return '+$value';
      }
      return '$value';
    } else {
      return "";
    }
  }

  String getEnemyText() {
    if (!isMe) {
      if (value > 0) {
        return '+$value';
      }
      return '$value';
    } else {
      return "";
    }
  }

  Color getColor() {
    return value > 0 ? positiveColor : negativeColor;
  }

  String toJson() {
    return '{"meHealth": $meHealth, "enemyHealth": $enemyHealth, "value": $value, "isMe": $isMe}';
  }

  static LogEntry fromJson(model) {
    LogEntry newLog = LogEntry(
        model["value"], model["meHealth"], model["enemyHealth"], model["isMe"]);
    //print("load log from JSON: $newLog");
    return newLog;
  }

  @override
  String toString() {
    return "($value -> $meHealth [$isMe] | $enemyHealth)";
  }
}
