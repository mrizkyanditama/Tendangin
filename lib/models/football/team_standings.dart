class TeamStandings{
  int rank;
  int points;
  int goal_diffs;
  String form;
  int played;
  int win;
  int draw;
  int lose;
  int goals_for;
  int goals_against;

  int team_id;
  String team_name;
  String team_logo;


  TeamStandings({this.rank, this.points, this.goal_diffs, this.form, this.played,
      this.win, this.draw, this.lose, this.goals_for, this.goals_against,
      this.team_id, this.team_name, this.team_logo});

  factory TeamStandings.fromMap(Map<String, dynamic> json) => TeamStandings(
    rank: json['rank'],
    points: json['points'],
    goal_diffs: json['goalsDiff'],
    form: json['form'],
    played: json['all']['played'],
    win: json['all']['win'],
    draw: json['all']['draw'],
    lose: json['all']['lose'],
    goals_for: json['all']['goals']['for'],
    goals_against: json['all']['goals']['against'],

    team_id: json['team']['id'],
    team_name: json['team']['name'],
    team_logo: json['team']['logo']
  );

}