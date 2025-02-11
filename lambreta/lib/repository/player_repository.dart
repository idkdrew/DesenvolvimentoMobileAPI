import 'package:firebase_database/firebase_database.dart';
import '../model/player.dart';
import '../controller/team_controller.dart';

class PlayerRepository {
  static final DatabaseReference _databaseUrl = FirebaseDatabase.instance.ref();

  static Future<List<Player>> getPlayers() async {
    try {
      final snapshot = await _databaseUrl.child('players').get();

      if (snapshot.exists && snapshot.value != null) {
        final data = snapshot.value;


        if (data is List) {
          return data
              .map((playerData) {
            if (playerData is Map) {
              return Player.fromMap(Map<String, dynamic>.from(playerData));
            } else {
              return null;
            }
          })
              .whereType<Player>()
              .where((player) => player.idTeam == TeamController.teamSelected)
              .toList();
        }
      }
    } catch (e) {
      print("Error occurred: $e");
    }

    return [];
  }

  static Future<Player?> getPlayerById(int id) async {
    id--;
    final snapshot = await _databaseUrl.child('players/$id').get();

    if (snapshot.exists && snapshot.value != null) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      return Player.fromMap(data);
    }

    return null;
  }

  static Future<void> createPlayer(String name, String position, int ovr) async {
    final nextIdSnapshot = await _databaseUrl.child('nextIdPlayer').get();
    int nextId = nextIdSnapshot.exists ? (nextIdSnapshot.value as int) : 1;

    final newPlayer = Player(
      id: nextId,
      idTeam: TeamController.teamSelected,
      name: name,
      position: position,
      ovr: ovr,
    );
    await _databaseUrl.child('nextIdPlayer').set(nextId + 1);
    nextId--;

    await _databaseUrl.child('players/$nextId').set(newPlayer.toMap());
  }
}
