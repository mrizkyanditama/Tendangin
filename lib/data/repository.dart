import 'dart:async';

import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/models/football/fixtures.dart';
import 'package:boilerplate/models/football/news.dart';
import 'package:boilerplate/models/football/standings.dart';
import 'package:boilerplate/models/football/team.dart';
import 'package:boilerplate/models/football/team_player.dart';

import 'package:sembast/sembast.dart';

import 'local/constants/db_constants.dart';
import 'network/apis/football/football_api.dart';


class Repository {
  // data source object

  final FootballApi _footballApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository(this._sharedPrefsHelper, this._footballApi);


  // Theme: --------------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value) =>
      _sharedPrefsHelper.changeBrightnessToDark(value);

  Future<bool> get isDarkMode => _sharedPrefsHelper.isDarkMode;

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  Future<String> get currentLanguage => _sharedPrefsHelper.currentLanguage;

  Future<void> setUsername(String username) =>
      _sharedPrefsHelper.setUsername(username);

  Future<String> get username => _sharedPrefsHelper.username;

  Future<void> setTeam(String team_id) =>
      _sharedPrefsHelper.setTeam(team_id);

  Future<String> get team => _sharedPrefsHelper.team;

  Future<void> setLeague(String league_id) =>
      _sharedPrefsHelper.setLeague(league_id);

  Future<String> get league => _sharedPrefsHelper.league;

  Future<List> getCountries() => _footballApi.getCountries();

  Future<List> getLeaguesByCountry(String country) => _footballApi.getLeaguesByCountry(country);

  Future<List> getTeamsByLeague(String league) => _footballApi.getTeamsByLeague(league);

  Future<Team> getTeamById(int id) => _footballApi.getTeamById(id);

  Future<Standings> getStandingsByLeagueId(int id) => _footballApi.getStandingsByLeagueId(id);

  Future<List<TeamPlayer>> getRosterByTeamId(int id) => _footballApi.getRosterByTeamId(id);

  Future<List<Fixtures>> getFixturesByTeamId(int id) => _footballApi.getFixturesByTeamId(id);

  Future<List<News>> getNewsByKeyword(String keyword) => _footballApi.getNewsByKeyword(keyword);
}
