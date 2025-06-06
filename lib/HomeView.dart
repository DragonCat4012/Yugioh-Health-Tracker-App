import 'package:flutter/material.dart';
import 'package:yugioh_health_tracker/GamesView.dart';
import 'package:yugioh_health_tracker/Util/DataHandler.dart';

import 'GameViews/LandscapeOne.dart';
import 'GameViews/PortraitView.dart';
import 'Util/Styling.dart';
import 'ViewComponents/LogView.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeView();
}

class _HomeView extends State<HomeView> {
  final DataHandler _storage = DataHandler();
  String _currentGame = ""; // TODO: maybe remove
  bool _shoudlUpdate = true;

  void newGame() async {
    _storage.createNewGame();

    setState(() {
      _currentGame = _storage.currentGame.game_uuid;
    });
  }

  @override
  void initState() {
    _storage.loadGames().then((value) {
      _currentGame = _storage.currentGame.game_uuid;
      // print('> Init View2: ${storage.currentGame.game_uuid}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Home"),
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(children: [
                      const Center(
                          child: Text("Continue Game",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      Center(
                          child: Text(_storage.currentGame.game_uuid,
                              style: const TextStyle(color: Colors.grey))),
                      SizedBox(
                          width: double.infinity,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PortraitView(
                                          title: "Game", storage: _storage)),
                                );
                              },
                              style: Styling.defaultButtonStyle(),
                              child: const Text("Portrait"))),
                      SizedBox(
                          width: double.infinity,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LandscapeOne(
                                          title: "Game", storage: _storage)),
                                );
                              },
                              style: Styling.defaultButtonStyle(),
                              child: const Text("Landscape"))),
                      const SizedBox(height: 50),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton.icon(
                            style: Styling.defaultButtonStyle(),
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              newGame();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LandscapeOne(
                                          title: "Game",
                                          storage: _storage,
                                        )),
                              );
                            },
                            label: const Text('New Game')),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton.icon(
                            style: Styling.defaultButtonStyle(),
                            icon: const Icon(Icons.folder_open),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GamesView(
                                          storage: _storage,
                                          onTap: () {
                                            setState(() {
                                              _shoudlUpdate = !_shoudlUpdate;
                                            });
                                          },
                                        )),
                              );
                            },
                            label: const Text('All Games')),
                      ),
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
                                        logEntries: _storage.currentGame.log)),
                              );
                            },
                            style: Styling.defaultButtonStyle(),
                            child: const Text("Current Games Logs")),
                      )
                    ])))));
  }
}
