import 'dart:async';
import 'dart:convert';

import 'package:boilerplate/data/network/constants/endpoints-football.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/models/football/fixtures.dart';
import 'package:boilerplate/models/football/news.dart';
import 'package:boilerplate/models/football/standings.dart';
import 'package:boilerplate/models/football/team.dart';
import 'package:boilerplate/models/football/team_fixtures.dart';
import 'package:boilerplate/models/football/team_player.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:intl/intl.dart';

class FootballApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  FootballApi(this._dioClient, this._restClient);

  /// Returns list of post in response
  Future<List> getCountries() async {
    try {
      final res = await _dioClient.get(
          EndpointsFootball.getCountries,
          options: buildCacheOptions(Duration(days: 1))
      );
      return res['response'];
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<List> getLeaguesByCountry(String country) async {
    try {
      final res = await _dioClient.get(
          EndpointsFootball.getLeagues,
          queryParameters: {"country": country, "type":"league"},
          options: buildCacheOptions(Duration(days: 1))
      );
      return res['response'];
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<List> getTeamsByLeague(String league) async {
    try {
      final res = await _dioClient.get(
          EndpointsFootball.getTeams,
          queryParameters: {"league": league, "season": 2019},
          options: buildCacheOptions(Duration(days: 1))
      );
      return res['response'];
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Team> getTeamById(int id) async {
    try {
      final res = await _dioClient.get(
        EndpointsFootball.getTeams,
        queryParameters: {"id": id},
        options: buildCacheOptions(Duration(days: 1)),
      );
      final team_raw = res['response'][0];
      Team team = Team.fromMap(team_raw);
      return team;
    }catch (e){
      print(e.toString());
      throw e;
    }
  }

  Future<Standings> getStandingsByLeagueId(int id, {int season:2020}) async{
    try{
      final res = await _dioClient.get(
        EndpointsFootball.getStandings,
        queryParameters: {"league":id, "season":season},
        options: buildCacheOptions(Duration(days: 1)),
      );
      if(res['results'] == 0){
        return await getStandingsByLeagueId(id, season: 2019);
      }

      final standings_raw = res['response'][0]['league'];
      Standings standings = Standings.fromMap(standings_raw);
      return standings;
    }catch (e){
      print(e.toString());
      throw e;
    }
  }

  Future<List<TeamPlayer>> getRosterByTeamId(int id, {int page = 1, int season=2019}) async{
    try{
      final res = await _dioClient.get(
        EndpointsFootball.getPlayers,
        queryParameters: {"team":id, "season":season, "page":page},
        options: buildCacheOptions(Duration(days: 1)),
      );
      List<dynamic> res_raw = res['response'];
      List<TeamPlayer> players = List();

      players = res_raw.map((e) => TeamPlayer.fromMap(e)).toList();

      int pages = res['paging']['total'];
      if(page<pages){
        players.addAll(await getRosterByTeamId(id, page: page+1, season: season));
      }
      return players;
    }catch (e){
      print(e.toString());
      throw e;
    }
  }

  Future<List<Fixtures>> getFixturesByTeamId(int id, {int season=2020}) async{
    try{
      final res = await _dioClient.get(
        EndpointsFootball.getFixtures,
        queryParameters: {"team":id, "season":season},
        options: buildCacheOptions(Duration(days: 1)),
      );
      if(res['results'] == 0){
        return await getFixturesByTeamId(id, season: 2019);
      }
      List<dynamic> fixtures_raw = res['response'];
      List<Fixtures> fixtures = List();
      fixtures = fixtures_raw.map((e) => Fixtures.fromMap(e)).toList();
      fixtures.sort((a,b) => a.date.compareTo(b.date));
      return fixtures;
    }catch (e){
      print(e.toString());
      throw e;
    }
  }

  Future<List<News>> getNewsByKeyword(String keyword) async{
    try{
      String cleaned_keyword = keyword.toLowerCase().replaceAll(" ", "-");
      String final_keyword = cleaned_keyword + "-football";
      final res = await _dioClient.get(
        EndpointsFootball.getNews,
        queryParameters: {
          "q":final_keyword,
          "from": DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 30))),
          "sortBy":"relevancy",
          "apiKey":"61526c2a770740118ff2d92993c5c336"
        },
        options: buildCacheOptions(Duration(days: 1)),
      );
      List<dynamic> news_raw = res['articles'];
      List<News> news = List();
      news = news_raw.map((e) => News.fromMap(e)).toList();
      return news;
    }catch (e){
      print(e.toString());
      throw e;
    }
  }




/// sample api call with default rest client
//  Future<PostsList> getPosts() {
//
//    return _restClient
//        .get(Endpoints.getPosts)
//        .then((dynamic res) => PostsList.fromJson(res))
//        .catchError((error) => throw NetworkException(message: error));
//  }

}
