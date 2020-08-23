class TeamPlayer{
  String name;
  int age;
  String nationality;

  String height;
  String weight;

  String photo;

  String position;


  TeamPlayer({this.name, this.age, this.nationality, this.height, this.weight,
      this.photo, this.position});

  factory TeamPlayer.fromMap(Map<String, dynamic> json) => TeamPlayer(
    name: json['player']['name'],
    age: json['player']['age'],
    nationality: json['player']['nationality'],
    height: json['player']['height'],
    weight: json['player']['weight'],
    photo: json['player']['photo'],
    position: json['statistics'][0]['games']['position']
  );
}