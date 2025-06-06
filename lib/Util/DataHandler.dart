import 'dart:convert';
import 'package:yugioh_health_tracker/Util/Game.dart';
import 'package:yugioh_health_tracker/Util/LogEntry.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DataHandler {
  var fileHandler = FileHandler();
  Game currentGame = Game();
  List<Game> games = List.empty();

  DataHandler();

  Future<void> loadGames() async {
    var filecontent = await fileHandler.readFile();
    Iterable l = json.decode(filecontent);
    List<Game> loadedGames =
        List<Game>.from(l.map((model) => Game.fromJson(model)));
    games = loadedGames;
    print("Loaded Games: ${loadedGames.length}");

    // setup Class
    if (games.isEmpty) {
      print("no games could be loaded");
      currentGame = Game();
      games = [...games, currentGame];

      fileHandler.writeGames(games);
    } else {
      currentGame = games.last;
    }

    print("init data: ${games.length} games");
    print("init cur: ${currentGame.game_uuid}");
  }

  void addLogEntryToGame(LogEntry entry) {
    currentGame.addEntry(entry);

    games.removeWhere((item) => item.game_uuid == currentGame.game_uuid);
    games.add(currentGame);

    fileHandler.writeGames(games); // TODO:; check if needs to be called
  }

  void createNewGame() {
    currentGame = Game();
    games.add(currentGame);
    print("new game: ${currentGame.game_uuid}");
    fileHandler.writeGames(games);
  }

  void deleteGame(String gameUUID) {
    games = games.where((i) => i.game_uuid != gameUUID).toList();
    if (gameUUID == currentGame.game_uuid) {
      currentGame = games.last;
    }
    fileHandler.writeGames(games);
  }

  void switchCurrentGame(String newGameUUID) {
      currentGame =  games.where((i) => i.game_uuid == newGameUUID).first;
      // push currentGame to be the last
      games.remove(currentGame);
      games.add(currentGame);
  }
}

class FileHandler {
  String savePath = "gameSave.txt";

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _saveFile async {
    final path = await _localPath;
    return File('$path/$savePath');
  }

  Future<File> writeGames(games) async {
    print("Save games: ${games.length}");
    final file = await _saveFile;
    List<String> gameList = [];

    games.forEach((element) {
      gameList.add(element.toJson());
    });
    return file.writeAsString('$gameList');
  }

  Future<String> readFile() async {
    try {
      final file = await _saveFile;
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return "[]";
    }
  }
}
