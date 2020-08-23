class TeamFixtures{
  String name;
  String logo;
  int score;

  TeamFixtures({this.name, this.logo, this.score});

  factory TeamFixtures.fromMapHome(Map<String, dynamic> json) => TeamFixtures(
    name: json['teams']['home']['name'],
    logo: json['teams']['home']['logo'],
    score: json['goals']['home']
  );

  factory TeamFixtures.fromMapAway(Map<String, dynamic> json) => TeamFixtures(
      name: json['teams']['away']['name'],
      logo: json['teams']['away']['logo'],
      score: json['goals']['away']
  );




}