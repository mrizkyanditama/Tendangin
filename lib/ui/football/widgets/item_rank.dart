import 'package:boilerplate/models/football/team_standings.dart';
import 'package:boilerplate/ui/football/res/styles.dart';
import 'package:flutter/material.dart';

import '../index.dart';

class ItemRank extends StatelessWidget {
  final int rank;
  final TeamStandings item;

  ItemRank({Key key, @required this.rank, @required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = TextStyles.textGrey16;

    Color bgColor = Colors.white;
    bgColor = rank % 2 == 1 ? Colors.grey[200] : Colors.white;


    return Material(
      color: bgColor,
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Text(
                      '$rank.',
                      style: style,
                    ),
                    Gaps.hGap5,
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage('${item.team_logo}'),
                      radius: 16.0,
                    ),
                    Gaps.hGap5,
                    Text('${item.team_name}')
                  ],
                ),
                flex: 7,
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Text('${item?.played}', textAlign: TextAlign.center),
                    Text('${item?.win}', textAlign: TextAlign.center),
                    Text('${item?.draw}',
                        textAlign: TextAlign.center),
                    Text('${item?.lose}', textAlign: TextAlign.center),
                    Text('${item?.points}', textAlign: TextAlign.center),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                ),
                flex: 3,
              ),
            ],
          ),
        ),
//        onTap: () => pushNewPage(
//            context, TeamHomePage(id: item.teamId, title: item.name)),
      ),
    );
  }
}
