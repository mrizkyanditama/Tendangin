import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/main.dart';
import 'package:boilerplate/models/football/fixtures.dart';
import 'package:boilerplate/ui/football/enum/enum.dart';
import 'package:boilerplate/ui/football/res/styles.dart';
import 'package:boilerplate/ui/football/ui-football/loader.dart';
import 'package:boilerplate/ui/football/widgets/item_schedule.dart';
import 'package:boilerplate/ui/football/widgets/stick_widget.dart';
import 'package:flutter/material.dart';

import '../index.dart';

class TeamSchedulePage extends StatefulWidget {
  final int id;

  TeamSchedulePage({Key key, @required this.id}) : super(key: key);

  @override
  createState() => _TeamSchedulePageState();
}

class _TeamSchedulePageState extends State<TeamSchedulePage>
    with AutomaticKeepAliveClientMixin<TeamSchedulePage> {
  List<Fixtures> schedule = [];

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
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, itemIndex) =>
                ItemSchedule(item: schedule[itemIndex], isTeam: true),
            separatorBuilder: (_, __) => Gaps.vGap(1.0),
            itemCount: schedule.length),
        loaderState: state);
  }

  void getDataByTeamId(int id) async {
    List<Fixtures> list = await _repository.getFixturesByTeamId(id);

    schedule.addAll(list);
    if (mounted) {
      setState(() {
        state = LoaderState.Succeed;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
