class Result {
  final int awayGoal;
  final int homeGoal;
  final int id;
  final int idTeam;
  final bool isHome;
  final String urlImageOpponent;

  Result({
    required this.awayGoal,
    required this.homeGoal,
    required this.id,
    required this.idTeam,
    required this.isHome,
    required this.urlImageOpponent,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idTeam': idTeam,
      'isHome': isHome,
      'urlImageOpponent': urlImageOpponent,
      'homeGoal': homeGoal,
      'awayGoal': awayGoal,
    };
  }

  // A função fromMap que faz a conversão dos dados
  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      awayGoal: map['awayGoal'] as int,
      homeGoal: map['homeGoal'] as int,
      id: map['id'] as int,
      idTeam: map['idTeam'] as int,
      isHome: map['isHome'] as bool,
      urlImageOpponent: map['urlImageOpponent'].toString(),
    );
  }
}
