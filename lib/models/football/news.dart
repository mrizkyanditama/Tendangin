class News{
  String title;
  String description;
  String url;
  String url_image;
  String source;

  News({this.title, this.description, this.url, this.url_image, this.source});

  factory News.fromMap(Map<String, dynamic> json) => News(
    title: json['title'],
    description: json['description'],
    url: json['url'],
    url_image: json['urlToImage'],
    source: json['source']['name']
  );

}