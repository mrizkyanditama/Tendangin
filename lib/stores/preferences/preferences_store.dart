import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/language/Language.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

part 'preferences_store.g.dart';

class PreferencesStore = _PreferencesStore with _$PreferencesStore;

abstract class _PreferencesStore with Store {

  // repository instance
  final Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();


  // constructor:---------------------------------------------------------------
  _PreferencesStore(Repository repository)
      : this._repository = repository {
    init();
  }

  // store variables:-----------------------------------------------------------
  @observable
  String _league = "";

  @observable
  String _team = "";

  @computed
  String get league => _league;

  @computed
  String get team => _team;

  // actions:-------------------------------------------------------------------


  @action
  void setLeague(String league) {
    _league = league;
    _repository.setLeague(league);
  }

  @action
  void setTeam(String team) {
    _team = team;
    _repository.setTeam(team);
  }

  // general:-------------------------------------------------------------------
  void init() async {
    // getting current language from shared preference
    _repository?.team?.then((team) {
      if (team != null) {
        _team = team;
      }
    });
    _repository?.league?.then((league) {
      if (league != null) {
        _league = league;
      }
    });
  }

  // dispose:-------------------------------------------------------------------
  @override
  dispose() {}
}
