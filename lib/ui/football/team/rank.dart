import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/main.dart';
import 'package:boilerplate/models/football/standings.dart';
import 'package:boilerplate/ui/football/enum/enum.dart';
import 'package:boilerplate/ui/football/ui-football/loader.dart';
import 'package:boilerplate/ui/football/widgets/stick_widget.dart';
import 'package:flutter/material.dart';

import '../index.dart';

class RankPage extends StatefulWidget {
  final String league_id;
  
  RankPage({Key key, @required this.league_id}) : super(key: key);

  @override
  createState() => _RankPageState();
}

class _RankPageState extends State<RankPage>
    with AutomaticKeepAliveClientMixin<RankPage> {
  Standings standings;

  LoaderState state = LoaderState.Loading;

  final Repository _repository = appComponent.getRepository();

  @override
  void initState() {
    super.initState();

    getRankData(widget.league_id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoaderContainer(
        contentView: StickWidget(
            stickHeader: Container(
              height: 35,
              color: Colors.brown[200],
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Rank'),
                    flex: 7,
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Text('P', textAlign: TextAlign.center),
                        Text('W', textAlign: TextAlign.center),
                        Text('D', textAlign: TextAlign.center),
                        Text('L', textAlign: TextAlign.center),
                        Text('Pts', textAlign: TextAlign.center),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    ),
                    flex: 3,
                  ),
                ],
              ),
            ),
            stickContent: ListView.builder(
              itemBuilder: (_, rank) => ItemRank(
                rank: rank + 1,
                item: standings?.teams[rank],
              ),
              itemCount: standings?.teams?.length,
              physics: NeverScrollableScrollPhysics(),
            )),
        loaderState: state);
  }

  void getRankData(String id) async {
    Standings res = await _repository.getStandingsByLeagueId(int.parse(id));

    setState(() {
      standings = res;
    });

    if (mounted) {
      setState(() {
        state = LoaderState.Succeed;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
