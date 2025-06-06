import 'package:uuid/uuid.dart';
import 'package:yugioh_health_tracker/Util/LogEntry.dart';

class Game {
  String game_uuid = "";
  List<LogEntry> log = [];

  Game() {
    log = [];
    const uuid = Uuid();
    game_uuid = uuid.v1().toString();
  }

  Game.fromParam(this.log, this.game_uuid);

  void addEntry(LogEntry entry) {
    log = [entry, ...log];
  }

  String toJson() {
    List<String> entries = [];
    for (var element in log) {
      entries.add(element.toJson());
    }
    return '{"game_uuid": "$game_uuid", "log": [${entries.join(", ")}]}';
  }

  static Game fromJson(model) {
    List<LogEntry> newLog = [];
    model["log"].forEach((element) {
      newLog.add(LogEntry.fromJson(element));
    });

    Game newGame = Game.fromParam(newLog, model["game_uuid"]);
    return newGame;
  }

  @override
  String toString() {
    return "($game_uuid: ${log.length})";
  }
}
