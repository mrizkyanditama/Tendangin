import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/main.dart';
import 'package:boilerplate/models/football/team.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/preferences/preferences_store.dart';
import 'package:boilerplate/ui/football/enum/enum.dart';
import 'package:boilerplate/ui/football/res/styles.dart';
import 'package:boilerplate/ui/football/team/news.dart';
import 'package:boilerplate/ui/football/team/rank.dart';
import 'package:boilerplate/ui/football/ui-football/image_load_view.dart';
import 'package:boilerplate/ui/football/ui-football/loader.dart';
import 'package:boilerplate/ui/initial/initial.dart';
import 'package:boilerplate/utils/utils/route_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../index.dart';

class TeamHomePage extends StatefulWidget {
  final String id;

  TeamHomePage({Key key, @required this.id}) : super(key: key);

  @override
  createState() => _TeamHomePageState();
}

class _TeamHomePageState extends State<TeamHomePage>
    with SingleTickerProviderStateMixin {
  LoaderState state = LoaderState.Loading;

  ScrollController scrollController;
  TabController _tabController;

  List<String> titleTabs = ['Standing', 'Roster', 'Fixtures', 'News'];

  List<Tab> tabs = [];

  Team team;

  final Repository _repository = appComponent.getRepository();

  PreferencesStore _preferencesStore;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(vsync: this, length: titleTabs.length);

    tabs = titleTabs.map((title) => Tab(text: "$title")).toList();

    getTeamInfo(widget.id);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _preferencesStore = Provider.of<PreferencesStore>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

//  void clearPrefs() async{
//    final preferences = await SharedPreferences.getInstance();
//    await preferences.remove('');
//  }

  void changeTeam() {
    Navigator.pop(context);
    pushNewPageBack(context, InitialPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange),
              child: Text(
                'Tendangin',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Change team'),
              onTap: changeTeam,
            ),
          ],
        ),
      ),
      body: LoaderContainer(
        contentView: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
                pinned: true,
                centerTitle: true,
                expandedHeight: 250,
                title: Text('${team?.name}'),
                bottom: TabBar(
                  controller: _tabController,
                  tabs: tabs,
                  isScrollable: true,
                  indicatorColor: Colors.orange,
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    margin: EdgeInsets.only(bottom: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ImageLoadView('${team?.logo}',
                            width: 74.0, height: 74.0),
                        Gaps.vGap5,
                        Text('${team?.name}', style: TextStyles.textBoldDark14),
                        Gaps.vGap5,
                        Container(
                          height: 18,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('${team?.founded}',
                                  style: TextStyles.textBoldDark14),
                              VerticalDivider(color: Colors.black),
                              Text('${team?.venue}',
                                  style: TextStyles.textBoldDark14),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: SafeArea(
            top: false,
            child: TabBarView(
              controller: _tabController,
              children: [
                RankPage(
                  league_id: _preferencesStore.league,
                ),
                TeamRosterPage(id: team?.id),
                TeamSchedulePage(id: team?.id),
                FootballNewsPage(name: team?.name)
              ],
            ),
          ),
        ),
        loaderState: state,
      ),
    );
  }

  void getTeamInfo(String id) async {
    team = await _repository.getTeamById(int.parse(widget.id));

    setState(() {
      state = LoaderState.Succeed;
    });
  }
}
