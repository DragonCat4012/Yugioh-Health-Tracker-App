import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yugioh_health_tracker/Util/DataHandler.dart';
import 'package:yugioh_health_tracker/ViewComponents/LogView.dart';

import '../GameViewModel.dart';
import '../Util/Styling.dart';
import '../ViewComponents/LifepointsOptionsView.dart';

class LandscapeOne extends StatefulWidget {
  const LandscapeOne({super.key, required this.title, required this.storage});
  final String title;
  final DataHandler storage;

  @override
  State<LandscapeOne> createState() => _LandscapeOne();
}

class _LandscapeOne extends State<LandscapeOne> {
  var vm = GameViewModel(8000);
  bool shouldBeUpdated = false;

  @override
  void initState() {
    super.initState();
    vm = GameViewModel.fromGame(8000, widget.storage.currentGame);
    setState(() {
      shouldBeUpdated = !shouldBeUpdated;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ListenableBuilder(
            listenable: vm,
            builder: (context, child) {
              return SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Row(
                      // Texts
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 150,
                            child: Text(
                              vm.get_health1(),
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: PURPLE,
                              ),
                            )),
                        Text(widget.storage.currentGame.game_uuid),
                        SizedBox(
                            width: 150,
                            child: Text(
                              '${vm.health2}',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: ORANGE,
                              ),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            width: 300,
                            height: 20,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(Styling.barRadius),
                                  bottomLeft:
                                      Radius.circular(Styling.barRadius)),
                              child: LinearProgressIndicator(
                                minHeight: 20,
                                value: vm.health1 / vm.maxHealth,
                                valueColor:
                                    const AlwaysStoppedAnimation<Color>(PURPLE),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            width: 300,
                            height: 20,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(Styling.barRadius),
                                  bottomRight:
                                      Radius.circular(Styling.barRadius)),
                              child: RotatedBox(
                                quarterTurns: 2,
                                child: LinearProgressIndicator(
                                  minHeight: 20,
                                  value: vm.health2 / vm.maxHealth,
                                  valueColor:
                                      const AlwaysStoppedAnimation(ORANGE),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          Expanded(
                              child: LifePointOptionsView(
                            vm: vm,
                            color: PURPLE,
                            target: 1,
                            storage: widget.storage,
                            onUpdate: () {},
                          )),
                          SizedBox(
                            width: 100,
                            child: ElevatedButton(
                              onPressed: widget.storage.currentGame.log.isEmpty
                                  ? null
                                  : () => navigateToLog(
                                      widget.storage.currentGame.log),
                              child: const Text('Log'),
                            ),
                          ),
                          Expanded(
                              child: LifePointOptionsView(
                                  vm: vm,
                                  color: ORANGE,
                                  target: 2,
                                  storage: widget.storage,
                                  onUpdate: () {})),
                        ],
                      )),
                ],
              ));
            }),
      ),
    );
  }

  void navigateToLog(logs) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LogPage(
              title: "Log", logEntries: widget.storage.currentGame.log)),
    );
  }
}
