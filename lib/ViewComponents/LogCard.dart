import 'package:flutter/material.dart';
import 'package:yugioh_health_tracker/Util/LogEntry.dart';

class LogCard extends StatelessWidget {
  final LogEntry entry;

  static const minWidth = 80.0;
  const LogCard(this.entry, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(2.0, 5.0, 5.0, 2.0),
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.7),
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                            width: minWidth,
                            child: Text(
                              '${entry.meHealth}',
                              style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurpleAccent),
                            )),
                        aloha(context, entry.getMeText()),
                        aloha(context, entry.getEnemyText()),
                        SizedBox(
                            width: minWidth,
                            child: Text(
                              '${entry.enemyHealth}',
                              style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange),
                            )),
                      ]),
                ])
            //   ),
            ));
  }

  Widget aloha(BuildContext context, value) {
    Widget child;
    if (value == '') {
      child = SizedBox(width: minWidth);
    } else {
      child = SizedBox(
          width: minWidth,
          child: Container(
              decoration: BoxDecoration(
                  color: entry.color,
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Center(
                child: Text(value,
                    style:
                        const TextStyle(fontSize: 18.0, color: Colors.black)),
              )));
    }
    return Padding(
        padding: const EdgeInsets.fromLTRB(2.0, 5.0, 2.0, 5.0),
        child: Container(child: child));
  }
}
