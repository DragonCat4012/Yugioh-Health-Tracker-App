import 'package:flutter/material.dart';
import 'package:yugioh_health_tracker/Util/DataHandler.dart';
import 'package:yugioh_health_tracker/Util/Game.dart';
import 'package:yugioh_health_tracker/ViewComponents/LogView.dart';

import 'Util/Styling.dart';

class GamesView extends StatefulWidget {
  const GamesView({super.key, required this.storage, required this.onTap});
  final DataHandler storage;
  final VoidCallback onTap;

  @override
  State<GamesView> createState() => _GamesView();
}

class _GamesView extends State<GamesView> {
  String currentGame = "";
  bool toBeUpdated = false;

  Widget getStarWidget(Game game) {
    return IconButton(
      padding: EdgeInsets.zero,
      color: (game.game_uuid == widget.storage.currentGame.game_uuid)
          ? Styling.secondary
          : Colors.grey,
      icon: const Icon(
        Icons.star,
      ),
      onPressed: () {
        widget.storage.switchCurrentGame(game.game_uuid);
        widget.onTap();
        setState(() {
          // reload view
          toBeUpdated = !toBeUpdated;
        });
      },
    );
  }

  Widget getTextWidgets(List<Game> games) {
    List<SizedBox> list = [];
    for (var i = 0; i < games.length; i++) {
      int logSize = games[i].log.length;

      list.add(
        SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).orientation == Orientation.portrait
                ? 100
                : 50,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextButton(
                style: games[i].log.isEmpty
                    ? Styling.defaultButtonStyleDisabled()
                    : Styling.defaultButtonStyle(),
                onPressed: games[i].log.isEmpty
                    ? null
                    : () => navigateToLog(games[i].log),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        games[i].game_uuid,
                        style: TextStyle(
                            color: getTextColorForGame(
                                games[i].game_uuid, logSize)),
                      ),
                    ),
                    Text(
                      '#$logSize',
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.delete,
                      ),
                      color: Colors.red,
                      onPressed: () {
                        widget.storage.deleteGame(games[i].game_uuid);
                        setState(() {
                          // reload view
                          toBeUpdated = !toBeUpdated;
                        });
                      },
                    ),
                    getStarWidget(games[i]),
                  ],
                ),
              ),
            )),
      );
    }
    return Column(children: list);
  }

  Color getTextColorForGame(String gameUUID, int size) {
    if (gameUUID == widget.storage.currentGame.game_uuid) {
      return Styling.accent;
    } else if (size > 0) {
      return Styling.secondary;
    } else {
      return Colors.grey;
    }
  }

  void navigateToLog(logs) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LogPage(title: "Log", logEntries: logs)),
    );
  }

  @override
  void initState() {
    super.initState();
    currentGame = widget.storage.currentGame.game_uuid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("All Games"),
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        currentGame,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    getTextWidgets(widget.storage.games.reversed.toList()),
                  ],
                ))),
      ),
    );
  }
}
