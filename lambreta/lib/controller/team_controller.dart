import '../model/team.dart';
import '../repository/team_repository.dart';

class TeamController {
  static int teamSelected = 0;
  static String urlImageSelected = "";

  Future<List<Team>> fetchTeams() async {
    try {
      return await TeamRepository.getTeams();
    } catch (e) {
      return [];
    }
  }

  Future<void> createTeam(String name, String urlImage) async {
    try {
      await TeamRepository.createTeam(name, urlImage);
    } catch (e) {

    }
  }

  Future<Team?> selectTeamById(int id, String urlImage) async {
    try {
      teamSelected = id;
      urlImageSelected = urlImage;
      return await TeamRepository.getTeamById(id);
    } catch (e) {
      print("Erro ao selecionar time: $e");
      return null;
    }
  }
}
