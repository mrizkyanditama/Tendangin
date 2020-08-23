import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/main.dart';
import 'package:boilerplate/stores/preferences/preferences_store.dart';
import 'package:boilerplate/ui/football/index.dart';
import 'package:boilerplate/utils/utils/route_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => new _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  TextEditingController _usernameController = TextEditingController();
  List<dynamic> _listCountry = List();
  List<dynamic> _listLeague = List();
  List<dynamic> _listTeam = List();
  final Repository _repository = appComponent.getRepository();
  PreferencesStore _preferencesStore;

  String _country;
  int _league;
  int _team;

  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];


  @override
  void initState() {
    super.initState();
    loadCountries();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _preferencesStore = Provider.of<PreferencesStore>(context);
  }

  void loadCountries() async {
    _repository.getCountries().then((value) {
      print(value);
      setState(() {
        _listCountry = value;
      });
    });
  }

  void loadLeaguesByCountry(String country) async {
    _repository.getLeaguesByCountry(country).then((value) {
      setState(() {
        _listLeague = value;
      });
    });
  }

  void loadTeamsByLeague(String league) async {
    _repository.getTeamsByLeague(league).then((value) {
      setState(() {
        _listTeam = value;
      });
    });
  }

  Widget buildCountryField() {
    return DropdownButtonFormField(
      hint: Text('Select country'),
      value: _country,
      items: _listCountry.map((item) {
        return DropdownMenuItem(
          child: Text(item['name']),
          value: item['name'],
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _country = value;
          _league = null;
          _team = null;
        });
        loadLeaguesByCountry(value);
      },
      validator: (value) {
        if (value == null) {
          return 'Please select country';
        }
      },
    );
  }

  Widget buildLeagueField() {
    return DropdownButtonFormField(
      hint: Text('Select league'),
      value: _league,
      items: _listLeague.map((item) {
        return DropdownMenuItem(
          child: Text(item['league']['name']),
          value: item['league']['id'],
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _league = value;
          _team = null;
        });
        loadTeamsByLeague(value.toString());
      },
      validator: (value) {
        if (value == null) {
          return 'Please select league';
        }
      },
    );
  }

  Widget buildTeamField() {
    return DropdownButtonFormField(
      value: _team,
      hint: Text('Select team'),
      items: _listTeam.map((item) {
        return DropdownMenuItem(
          child: Text(item['team']['name']),
          value: item['team']['id'],
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _team = value;
        });
      },
      validator: (value) {
        if (value == null) {
          return 'Please select team';
        }
      },
    );
  }

  int currentStep = 0;
  bool complete = false;

  next() {
    if (formKeys[currentStep].currentState.validate()) {
      currentStep + 1 != 3
          ? goTo(currentStep + 1)
          : completeInitial();
    }
  }

  completeInitial(){
    setState(() => complete = true);
    _preferencesStore.setTeam(_team.toString());
    _preferencesStore.setLeague(_league.toString());
    pushAndRemovePage(context, TeamHomePage(id: _preferencesStore.team,));
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  @override
  Widget build(BuildContext context) {
    List<Step> steps = [
      Step(
        isActive: false,
        state: StepState.indexed,
        title: const Text('Select country of your favourite team'),
        content: Form(
          key: formKeys[0],
          child: Column(
            children: <Widget>[
              buildCountryField(),
            ],
          ),
        ),
      ),
      Step(
        state: StepState.indexed,
        title: const Text('Select league of your favourite team'),
        content: Form(
          key: formKeys[1],
          child: Column(
            children: <Widget>[if (_listLeague.length > 0) buildLeagueField()],
          ),
        ),
      ),
      Step(
        state: StepState.indexed,
        title: const Text('Select your favourite team'),
        content: Form(
          key: formKeys[2],
          child: Column(
            children: <Widget>[if (_listTeam.length > 0) buildTeamField()],
          ),
        ),
      ),
    ];

    return new Scaffold(
        appBar: AppBar(
          title: Text('Pick favourite team'),
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: Stepper(
              currentStep: currentStep,
              steps: steps,
              type: StepperType.vertical,
              onStepContinue: next,
              onStepCancel: cancel,
            ),
          ),
        ]));
  }
}
