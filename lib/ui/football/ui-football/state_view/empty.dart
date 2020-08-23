import 'package:boilerplate/ui/football/res/styles.dart';
import 'package:boilerplate/ui/football/ui-football/button.dart';
import 'package:flutter/material.dart';


class EmptyPage extends StatelessWidget {
  final String text;
  final String imageAsset;
  final Function onPresses;
  final String pressText;

  EmptyPage(
      {Key key,
      this.text: 'No data',
      this.imageAsset: 'assets/images/empty.jpeg',
      this.onPresses,
      this.pressText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Image.asset('$imageAsset', width: 150, height: 150),
        Gaps.vGap20,
        Text('$text'),
        Gaps.vGap20,
        Offstage(
            offstage: onPresses == null,
            child: Button(
              onPressed: onPresses,
              child: Text(pressText ?? 'Add', style: TextStyle(fontSize: 18)),
              width: 110,
              halfRadius: true,
            ))
      ]),
    );
  }
}
