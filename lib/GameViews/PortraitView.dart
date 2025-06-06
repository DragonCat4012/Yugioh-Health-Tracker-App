import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yugioh_health_tracker/ViewComponents/LogView.dart';

import '../GameViewModel.dart';
import '../Util/DataHandler.dart';
import '../Util/Styling.dart';
import '../ViewComponents/LifepointsOptionsView.dart';

class PortraitView extends StatefulWidget {
  const PortraitView({super.key, required this.title, required this.storage});

  final String title;
  final DataHandler storage;

  @override
  State<PortraitView> createState() => _PortraitView();
}

class _PortraitView extends State<PortraitView> {
  var _vm = GameViewModel(8000);
  bool _shouldBeUpdated = false;
  bool _isPurpleSelected = true;

  @override
  void initState() {
    super.initState();
    _vm = GameViewModel.fromGame(8000, widget.storage.currentGame);
    setState(() {
      _shouldBeUpdated = !_shouldBeUpdated;
    });
  }

  Widget getLifepointsOptions() {
    Color color = Styling.accent;
    int target = 1;
    if (!_isPurpleSelected) {
      color = Styling.secondary;
      target = 2;
    }
    return LifePointOptionsView(
      vm: _vm,
      color: color,
      target: target,
      storage: widget.storage,
      onUpdate: () {
        setState(() {
          _shouldBeUpdated = !_shouldBeUpdated;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RotatedBox(
                            quarterTurns: 3,
                            child: SizedBox(
                              width: Styling.portraitHealthHeight,
                              height: Styling.portraitHealthWidth,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(Styling.barRadius)),
                                child: LinearProgressIndicator(
                                    value: _vm.health1 / _vm.maxHealth,
                                    valueColor: const AlwaysStoppedAnimation(
                                        Styling.accent),
                                    backgroundColor: Colors.grey),
                              ),
                            )),
                        Column(children: [
                          Text('${_vm.health1}',
                              style: const TextStyle(
                                  color: Styling.accent,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                          Text('${_vm.health2}',
                              style: const TextStyle(
                                  color: Styling.secondary,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                        ]),
                        RotatedBox(
                            quarterTurns: 3,
                            child: SizedBox(
                                width: Styling.portraitHealthHeight,
                                height: Styling.portraitHealthWidth,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(Styling.barRadius)),
                                  child: LinearProgressIndicator(
                                      value: _vm.health2 / _vm.maxHealth,
                                      valueColor: const AlwaysStoppedAnimation(
                                          Styling.secondary),
                                      backgroundColor: Colors.grey),
                                ))),
                      ]),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: SegmentedButton(
                      segments: const [
                        ButtonSegment(
                            value: true,
                            label: Text("Purple"),
                            icon: Icon(null)),
                        ButtonSegment(
                            value: false,
                            label: Text("Orange"),
                            icon: Icon(null))
                      ],
                      selected: <bool>{_isPurpleSelected},
                      showSelectedIcon: false,
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      )),
                      onSelectionChanged: (newSelection) {
                        setState(() {
                          _isPurpleSelected = newSelection.first;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  getLifepointsOptions(),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LogPage(
                                    title: "UwU",
                                    // TODO: use real log
                                    logEntries:
                                        widget.storage.currentGame.log)),
                          );
                        },
                        style: Styling.defaultButtonStyle(),
                        child: const Text("Log")),
                  ),
                  Text(widget.storage.currentGame.game_uuid,
                      style: const TextStyle(color: Colors.grey))
                ]))));
  }
}
