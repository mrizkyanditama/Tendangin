import 'package:boilerplate/models/football/fixtures.dart';
import 'package:boilerplate/ui/football/res/styles.dart';
import 'package:boilerplate/ui/football/widgets/stick_widget.dart';
import 'package:flutter/material.dart';

import '../index.dart';

class ItemSchedule extends StatelessWidget {
  final Fixtures item;
  final bool isTeam;

  ItemSchedule({Key key, this.item, @required this.isTeam})
      : assert(isTeam != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
//    var leftStyle;
//    var rightStyle;
//    if(item.home != null && item.away != null) {
//      leftStyle = item?.home?.score > item?.away?.score
//          ? TextStyles.textBoldBlue14
//          : TextStyles.textGrey14;
//      rightStyle = item?.home?.score > item?.away?.score
//          ? TextStyles.textGrey14
//          : TextStyles.textBoldBlue14;
//    }else{
//      leftStyle = TextStyles.textGrey14;
//      rightStyle = TextStyles.textGrey14;
//    }

    return Material(
      color: Colors.white,
      child: InkWell(
//        onTap: item.matchPeriod == "0"
//            ? null
//            : () => pushNewPage(context, MatchPage(mid: item.mid)),
        child: StickWidget(
          stickHeader: Container(
            height: 35,
            color: Colors.grey[200],
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    item?.date?.day.toString() +
                        " - " +
                        item?.date?.month.toString() +
                        " - " +
                        item?.date?.year.toString(),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  child: Text(
                    item?.competition,
                    textAlign: TextAlign.right,
                  ),
                )
              ],
            ),
          ),
          stickContent: Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage('${item?.home?.logo}'),
                          radius: 15,
                      ),
                      Gaps.hGap8,
                      Expanded(
                          child: Text('${item?.home?.name}',
                              style: TextStyles.textDark14),
                      flex: 10,),
                      Expanded(
                        child: item.status == "NS" || item.status == "TBD" || item.status == "CANC"
                            ? Text(
                                'Not Started',
                                textAlign: TextAlign.center,
                                style: TextStyles.textGreyC14,
                              )
                            : RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: '${item?.home?.score}',
                                      style: TextStyles.textDark14),
                                  TextSpan(
                                      text: ' - ',
                                      style: TextStyles.textDark14),
                                  TextSpan(
                                      text: '${item?.away?.score}',
                                      style: TextStyles.textDark14)
                                ]),
                              ),
                        flex: 6,
                      ),
                      Expanded(
                        child: Text('${item?.away?.name}',
                            style: TextStyles.textDark14, textAlign: TextAlign.right,),
                        flex: 10,),
                      Gaps.hGap8,
                      CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage('${item?.away?.logo}'),
                          radius: 15,
                      ),
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
