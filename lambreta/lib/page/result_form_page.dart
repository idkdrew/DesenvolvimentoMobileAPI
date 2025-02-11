
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/player.dart';
import '../widget/custom_widgets.dart';
import '../controller/result_controller.dart';
import '../controller/player_controller.dart';
import '../controller/statistic_controller.dart';
import '../repository/api_repository.dart';

class ResultFormPage extends StatefulWidget {
  @override
  _ResultFormPage createState() => _ResultFormPage();
}

class _ResultFormPage extends State<ResultFormPage> {
  final ResultController resultController = ResultController();
  final PlayerController playerController = PlayerController();
  final StatisticController statisticController = StatisticController();
  final ApiRepository apiRepository = ApiRepository();

  bool isLoading = true;
  List<String> options = ['Casa', 'Visitante'];
  List<bool> selectedOption = <bool>[true, false];
  bool isHome = true;

  final TextEditingController homeGoalController = TextEditingController();
  final TextEditingController awayGoalController = TextEditingController();

  List<Player> players = [];
  Map<int, int> playerGoals = {};
  Map<int, int> playerAssists = {};

  List<dynamic> ligas = [];
  List<dynamic> times = [];
  String? ligaSelecionada;
  String? timeSelecionado;

  @override
  void initState() {
    super.initState();
    homeGoalController.text = "";
    awayGoalController.text = "";
    fetchLigas();
    fetchPlayers();
  }

  void fetchLigas() async {
    try {
      var result = await apiRepository.getData("liga/pesquisar");
      setState(() {
        ligas = result;
      });
    } catch (e) {
      print("Erro ao buscar ligas: $e");
    }
  }

  void fetchTimes(String idLiga) async {
    try {
      var result = await apiRepository.getData("time/pesquisar/$idLiga");
      setState(() {
        times = result;
        timeSelecionado = null;
      });
    } catch (e) {
      print("Erro ao buscar times: $e");
    }
  }

  Future<void> fetchPlayers() async {
    setState(() {
      isLoading = true;
    });
    try {
      final fetchPlayers = await playerController.fetchPlayers();
      setState(() {
        players = fetchPlayers;
        for (var player in players) {
          playerGoals[player.id] = 0;
          playerAssists[player.id] = 0;
        }
      });
    } catch (e) {
      print("Erro ao buscar jogadores: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void updatePlayerGoal(int idPlayer, int goal) {
    setState(() {
      playerGoals[idPlayer] = goal;
    });
  }

  void updatePlayerAssist(int idPlayer, int assist) {
    setState(() {
      playerAssists[idPlayer] = assist;
    });
  }

  void create() async {
    if (homeGoalController.text.isEmpty ||
        awayGoalController.text.isEmpty ||
        timeSelecionado == null) {
      CustomSnackBarError.show(context, "Preencha todos os campos!");
      return;
    }

    try {
      await resultController.createResult(
        isHome,
        timeSelecionado!,
        int.parse(homeGoalController.text),
        int.parse(awayGoalController.text),
      );
      int lastId = await resultController.getLastId();

      for (var player in players) {
        await statisticController.createStatistic(
          lastId,
          player.id,
          playerGoals[player.id] ?? 0,
          playerAssists[player.id] ?? 0,
        );
      }
      CustomSnackBarSucess.show(context, "Resultado adicionado!");

      setState(() {});
      Navigator.of(context).pop(true);
    } catch (e) {
      CustomSnackBarError.show(context, "Erro ao adicionar resultado !");
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut().then((user) => {
      CustomSnackBarError.show(context, "Saindo!"),
      Navigator.pushReplacementNamed(context, '/'),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Novo Resultado",
        onLogout: logout,
      ),
      backgroundColor: const Color(0xFFE0E0E0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomSizedBox(),
            Center(
              child: ToggleButtons(
                direction: Axis.horizontal,
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < selectedOption.length; i++) {
                      selectedOption[i] = i == index;
                      isHome = i == 0;
                    }
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: Color(0xFF3366CC),
                selectedColor: Color(0xFFCCE5FF),
                fillColor: Color(0xFF3366CC),
                color: Color(0xFF3366CC),
                constraints: const BoxConstraints(
                  minHeight: 40.0,
                  minWidth: 80.0,
                ),
                isSelected: selectedOption,
                children: options.map((option) {
                  return Text(option);
                }).toList(),
              ),
            ),
            CustomSizedBox(),

            Text("Selecione uma liga:", style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: ligaSelecionada,
              isExpanded: true,
              hint: Text("Escolha uma liga"),
              items: ligas.map((liga) {
                return DropdownMenuItem<String>(
                  value: liga['id'].toString(),
                  child: Text(liga['nome']),
                );
              }).toList(),
              onChanged: (String? novoValor) {
                setState(() {
                  ligaSelecionada = novoValor;
                  fetchTimes(novoValor!);
                });
              },
            ),

            CustomSizedBox(),


            Text("Selecione um time:", style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: timeSelecionado,
              isExpanded: true,
              hint: Text(times.isEmpty ? "Selecione uma liga primeiro" : "Escolha um time"),
              items: times.map((time) {
                return DropdownMenuItem<String>(
                  value: time['id'].toString(),
                  child: Text(time['nome']),
                );
              }).toList(),
              onChanged: (String? novoValor) {
                setState(() {
                  timeSelecionado = novoValor;
                });
              },
            ),

            CustomSizedBox(),
            CustomInput(
                label: 'Gols da Casa',
                keyboardType: TextInputType.number,
                controller: homeGoalController),
            CustomSizedBox(),
            CustomInput(
                label: 'Gols do Visitante',
                keyboardType: TextInputType.number,
                controller: awayGoalController),
            CustomSizedBox(),
            Expanded(
              child: ListView.builder(
                itemCount: players.length,
                itemBuilder: (context, index) {
                  final player = players[index];
                  return ResultPlayerCard(
                    name: player.name,
                    position: player.position,
                    onGoalChanged: (goal) {
                      updatePlayerGoal(player.id, goal);
                    },
                    onAssistChanged: (assist) {
                      updatePlayerAssist(player.id, assist);
                    },
                  );
                },
              ),
            ),
            CustomSizedBox(),
            CustomButton(
              text: 'Adicionar Resultado',
              onPressed: create,
            ),
          ],
        ),
      ),
    );
  }
}
