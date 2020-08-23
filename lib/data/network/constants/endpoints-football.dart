class EndpointsFootball {
  EndpointsFootball._();

  // base url
  static const String baseUrl =  "https://api-football-beta.p.rapidapi.com/";

  // receiveTimeout
  static const int receiveTimeout = 5000;

  // connectTimeout
  static const int connectionTimeout = 3000;

  // booking endpoints
  static const String getCountries = baseUrl + "/countries";

  static const String getLeagues = baseUrl + "/leagues";

  static const String getTeams = baseUrl + "/teams";

  static const String getStandings = baseUrl + "/standings";

  static const String getPlayers = baseUrl + "/players";

  static const String getFixtures = baseUrl + "/fixtures";

  static const String getNews = "http://newsapi.org/v2/everything";

  static Map<String, String> headers = {
  'Content-Type': 'application/json; charset=utf-8',
  "x-rapidapi-host":"api-football-beta.p.rapidapi.com",
  "x-rapidapi-key": "b4e0639130mshb980a006a87ff4cp1fbc8djsn924d2b07155e"
  };
}