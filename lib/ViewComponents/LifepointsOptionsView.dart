import 'package:flutter/material.dart';
import 'package:yugioh_health_tracker/Util/DataHandler.dart';
import 'package:yugioh_health_tracker/Util/LogEntry.dart';

import '../GameViewModel.dart';

class LifePointOptionsView extends StatefulWidget {
  const LifePointOptionsView(
      {super.key,
      required this.vm,
      required this.color,
      required this.target,
      required this.storage,
      required this.onUpdate});

  final GameViewModel vm;
  final Color color;
  final int target;
  final DataHandler storage;
  final VoidCallback onUpdate;

  @override
  State<LifePointOptionsView> createState() => _LifePointOptionsView();
}

class _LifePointOptionsView extends State<LifePointOptionsView> {
  int _selectedAmount = 0;
  bool subdivide = false;

  void _editPlayer1Life() {
    int amount = subdivide ? (-1) * _selectedAmount : _selectedAmount;

    setState(() {
      widget.vm.edit_health(widget.target, amount);
      widget.storage.addLogEntryToGame(LogEntry(
          amount, widget.vm.health1, widget.vm.health2, widget.target == 1));
    });
    widget.onUpdate();
  }

  void _setAmount(int amount) {
    setState(() {
      _selectedAmount = amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: buttonGroup(side: 1));
  }

  Widget buttonGroup({int side = 0}) {
    return Column(children: [
      Row(children: [
        Expanded(
            child: TextButton(
                style: buttonStyle(),
                child: const Text("4000"),
                onPressed: () {
                  _setAmount(4000);
                })),
        Expanded(
            child: TextButton(
                style: buttonStyle(),
                child: const Text("2000"),
                onPressed: () {
                  _setAmount(2000);
                })),
        Expanded(
            child: TextButton(
                style: buttonStyle(),
                child: const Text("1000"),
                onPressed: () {
                  _setAmount(1000);
                })),
      ]),
      Row(children: [
        Expanded(
            child: TextButton(
                style: buttonStyle(),
                child: const Text("500"),
                onPressed: () {
                  _setAmount(500);
                })),
        Expanded(
            child: TextButton(
                style: buttonStyle(),
                child: const Text("100"),
                onPressed: () {
                  _setAmount(100);
                })),
        Expanded(
            child: TextButton(
                style: buttonStyle(),
                child: const Text("50"),
                onPressed: () {
                  _setAmount(50);
                })),
      ]),
      Row(children: [
        Expanded(
            child: TextButton(
                style: buttonStyleColored(Colors.red),
                child: const Text("-"),
                onPressed: () {
                  subdivide = true;
                  _editPlayer1Life();
                })),
        Expanded(child: Center(child: Text('$_selectedAmount'))),
        Expanded(
            child: TextButton(
                style: buttonStyleColored(Colors.green),
                child: const Text("+"),
                onPressed: () {
                  subdivide = false;
                  _editPlayer1Life();
                })),
      ])
    ]);
  }

  ButtonStyle buttonStyle() {
    return ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(width: 1, color: widget.color))),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
        ));
  }

  ButtonStyle buttonStyleColored(Color color) {
    return ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(width: 1, color: color))),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
        ));
  }
}
