class Team{
  int id;
  String name;
  int founded;
  String logo;
  String venue;


  Team({this.id, this.name, this.founded, this.logo, this.venue});

  factory Team.fromMap(Map<String, dynamic> json) => Team(
    id: json['team']['id'],
    name: json['team']['name'],
    founded: json['team']['founded'],
    logo: json['team']['logo'],
    venue: json['venue']['name']
  );


}