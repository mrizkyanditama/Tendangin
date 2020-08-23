import 'package:boilerplate/models/football/team_player.dart';
import 'package:boilerplate/ui/football/res/styles.dart';
import 'package:flutter/material.dart';

import '../index.dart';

class ItemRoster extends StatelessWidget {
  final TeamPlayer player;
  final VoidCallback onPressed;

  ItemRoster({Key key, @required this.player, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,

      /// z轴的高度，设置card的阴影
      elevation: 20.0,

      /// 对Widget截取的行为，比如这里 Clip.antiAlias 指抗锯齿
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Material(
        child: InkWell(
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                    backgroundColor: Colors.black,
                    backgroundImage: NetworkImage('${player?.photo}'),
                    radius: 40),
                Gaps.hGap8,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('${player?.name}',
                              style: TextStyles.textBoldDark14),
                          Gaps.hGap8,
//                          Text('${player.nationality}',
//                              style: TextStyles.textWhite16)
                        ],
                      ),
                      Gaps.vGap16,
                      Row(
                        children: <Widget>[
                          Text('${player?.position}',
                              style: TextStyles.textDark14),
                          Gaps.hGap8,
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
