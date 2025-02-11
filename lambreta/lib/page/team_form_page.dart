import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lambreta/repository/api_repository.dart';

import '../widget/custom_widgets.dart';
import '../controller/team_controller.dart';

class TeamFormPage extends StatefulWidget {
  @override
  _TeamFormPage createState() => _TeamFormPage();
}

class _TeamFormPage extends State<TeamFormPage> {
  final TeamController teamController = TeamController();
  final ApiRepository apiRepository = ApiRepository();

  List<dynamic> ligas = [];
  List<dynamic> times = [];
  String? ligaSelecionada;
  String? timeSelecionado;

  @override
  void initState() {
    super.initState();
    fetchLigas();
  }

  // Busca as ligas na API
  void fetchLigas() async {
    try {
      var result = await apiRepository.getData("liga/pesquisar");
      setState(() {
        ligas = result;
      });
    } catch (e) {
      print("Erro ao buscar ligass: $e");
    }
  }

  // Busca os times com base na liga selecionada
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

  void create() async {
    if (ligaSelecionada == null || timeSelecionado == null) {
      CustomSnackBarError.show(context, "Preencha todos os campos!");
      return;
    }

    try {
      int bar = timeSelecionado!.indexOf("|");

      String name = timeSelecionado!.substring(bar+1);
      String id = timeSelecionado!.substring(0, bar);
      await teamController.createTeam(name, id);
      CustomSnackBarSucess.show(context, "Carreira adicionada!");

      setState(() {});
      Navigator.of(context).pop(true);
    } catch (e) {
      CustomSnackBarError.show(context, "Erro ao adicionar carreira!" + e.toString());
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut().then((user) => {
      Navigator.pushReplacementNamed(context, '/'),
      CustomSnackBarSucess.show(context, "Saindo!")
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Nova Carreira",
        onLogout: logout,
      ),
      backgroundColor: const Color(0xFFE0E0E0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                  value: time['id'].toString() + "|" + time['nome'],
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
            CustomButton(
              text: 'Criar Carreira',
              onPressed: create,
            ),
          ],
        ),
      ),
    );
  }
}
