import 'package:boilerplate/models/football/team_standings.dart';

class Standings {
  String league_name;
  String logo;
  int season;
  List<TeamStandings> teams;

  Standings({this.league_name, this.logo, this.season, this.teams});

  factory Standings.fromMap(Map<String, dynamic> json){
    List<TeamStandings> listTeam = List();
    List<dynamic> standings = json['standings'][0];
    listTeam = standings.map((e) => TeamStandings.fromMap(e)).toList();

    return Standings(
      league_name: json['name'],
      logo: json['logo'],
      season: json['season'],
      teams: listTeam
    );
  }

}
