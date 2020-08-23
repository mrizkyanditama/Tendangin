import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/main.dart';
import 'package:boilerplate/models/football/news.dart';
import 'package:boilerplate/ui/football/enum/enum.dart';
import 'package:boilerplate/ui/football/res/styles.dart';
import 'package:boilerplate/ui/football/ui-football/loader.dart';
import 'package:boilerplate/ui/football/ui-football/state_view/empty.dart';
import 'package:boilerplate/ui/football/ui-football/state_view/loading.dart';
import 'package:boilerplate/ui/football/widgets/item_news.dart';
import 'package:flutter/material.dart';


import '../index.dart';

class FootballNewsPage extends StatefulWidget {
  final String name;

  FootballNewsPage({Key key, @required this.name}) : super(key: key);

  @override
  createState() => _FootballNewsPageState();
}

class _FootballNewsPageState extends State<FootballNewsPage>
    with AutomaticKeepAliveClientMixin<FootballNewsPage> {
  LoaderState state = LoaderState.Loading;

  List<News> news = [];

  final Repository _repository = appComponent.getRepository();

  @override
  void initState() {
    super.initState();

    getNews(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoaderContainer(
      contentView: ListView.separated(
        padding: EdgeInsets.zero,
        itemBuilder: (_, index) => ItemNews(item: news[index]),
        itemCount: news.length,
        separatorBuilder: (BuildContext context, int index) => Gaps.vGap3,
      ),
      loaderState: state,
      loadingView: SizedBox(
        width: double.infinity,
        height: 300,
        child: LoadingView(),
      ),
      emptyView: SizedBox(
        width: double.infinity,
        height: 300,
        child: EmptyPage(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void getNews(String keyword) async {
    List<News> list = await _repository.getNewsByKeyword(keyword);

    news.clear();
    news.addAll(list);

    if (news.length > 0) {
      state = LoaderState.Succeed;
    } else {
      state = LoaderState.NoData;
    }

    setState(() {});
  }
}
