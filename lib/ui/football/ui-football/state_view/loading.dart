import 'package:boilerplate/ui/football/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Utils.isAndroid
              ? CircularProgressIndicator(
                  strokeWidth: 3.0, backgroundColor: Colors.orangeAccent)
              : CupertinoActivityIndicator(radius: 20.0),
          Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text('Loading', style: TextStyle(fontSize: 16)))
        ]),
      );
}
