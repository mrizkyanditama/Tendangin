import 'package:boilerplate/models/football/team_fixtures.dart';

class Fixtures{
  int id;
  DateTime date;
  String competition;
  String status;

  TeamFixtures home;
  TeamFixtures away;


  Fixtures({this.id, this.date, this.competition, this.status, this.home, this.away});

  factory Fixtures.fromMap(Map<String, dynamic> json) => Fixtures(
    id: json['fixture']['id'],
    date: DateTime.parse(json['fixture']['date']),
    competition: json['league']['name'],
    status: json['fixture']['status']['short'],
    home: TeamFixtures.fromMapHome(json),
    away: TeamFixtures.fromMapAway(json)
  );
}