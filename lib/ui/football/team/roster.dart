import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/main.dart';
import 'package:boilerplate/models/football/team_player.dart';
import 'package:boilerplate/ui/football/enum/enum.dart';
import 'package:boilerplate/ui/football/res/styles.dart';
import 'package:boilerplate/ui/football/ui-football/loader.dart';
import 'package:boilerplate/ui/football/widgets/item_roster.dart';
import 'package:flutter/material.dart';

import '../index.dart';

class TeamRosterPage extends StatefulWidget {
  final int id;

  TeamRosterPage({Key key, @required this.id}) : super(key: key);

  @override
  createState() => _TeamRosterPageState();
}

class _TeamRosterPageState extends State<TeamRosterPage>
    with AutomaticKeepAliveClientMixin<TeamRosterPage> {
  List<TeamPlayer> players = [];

  LoaderState state = LoaderState.Loading;

  final Repository _repository = appComponent.getRepository();

  @override
  void initState() {
    super.initState();

    getDataByTeamId(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoaderContainer(
        contentView: ListView.separated(
            padding: EdgeInsets.zero,
            itemBuilder: (_, index) => ItemRoster(
                  player: players[index],
//                  onPressed: () => pushNewPage(
//                    context,
//                    PlayerHomePage(id: players[index].playerId),
//                  ),
                ),
            separatorBuilder: (_, index) => Gaps.vGap(2.0),
            itemCount: players.length),
        loaderState: state);
  }

  void getDataByTeamId(int id) async {
    List<TeamPlayer> list = await _repository.getRosterByTeamId(id);
    players.addAll(list);
    if (mounted) {
      setState(() {
        state = LoaderState.Succeed;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
