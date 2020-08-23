// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PreferencesStore on _PreferencesStore, Store {
  Computed<String> _$leagueComputed;

  @override
  String get league =>
      (_$leagueComputed ??= Computed<String>(() => super.league,
              name: '_PreferencesStore.league'))
          .value;
  Computed<String> _$teamComputed;

  @override
  String get team => (_$teamComputed ??=
          Computed<String>(() => super.team, name: '_PreferencesStore.team'))
      .value;

  final _$_leagueAtom = Atom(name: '_PreferencesStore._league');

  @override
  String get _league {
    _$_leagueAtom.reportRead();
    return super._league;
  }

  @override
  set _league(String value) {
    _$_leagueAtom.reportWrite(value, super._league, () {
      super._league = value;
    });
  }

  final _$_teamAtom = Atom(name: '_PreferencesStore._team');

  @override
  String get _team {
    _$_teamAtom.reportRead();
    return super._team;
  }

  @override
  set _team(String value) {
    _$_teamAtom.reportWrite(value, super._team, () {
      super._team = value;
    });
  }

  final _$_PreferencesStoreActionController =
      ActionController(name: '_PreferencesStore');

  @override
  void setLeague(String league) {
    final _$actionInfo = _$_PreferencesStoreActionController.startAction(
        name: '_PreferencesStore.setLeague');
    try {
      return super.setLeague(league);
    } finally {
      _$_PreferencesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTeam(String team) {
    final _$actionInfo = _$_PreferencesStoreActionController.startAction(
        name: '_PreferencesStore.setTeam');
    try {
      return super.setTeam(team);
    } finally {
      _$_PreferencesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
league: ${league},
team: ${team}
    ''';
  }
}
