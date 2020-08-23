import 'package:boilerplate/models/football/news.dart';
import 'package:boilerplate/ui/football/res/styles.dart';
import 'package:boilerplate/ui/football/ui-football/image_load_view.dart';
import 'package:boilerplate/ui/football/widgets/web_view.dart';
import 'package:boilerplate/utils/utils/route_util.dart';
import 'package:flutter/material.dart';
import '../index.dart';

class ItemNews extends StatelessWidget {
  final News item;

  ItemNews({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        child: Container(
          height: 100,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Text(
                        '${item?.title}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            height: 1.5),
                      ),
                      Spacer(),
                      Text(
                        'source: ${item?.source}',
                        style: TextStyles.textGreyC14,
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),
              ImageLoadView(
                '${item?.url_image}',
                width: 150,
                fit: BoxFit.cover,
              )
            ],
          ),
        ),
        onTap: () => pushNewPage(
            context,
            WebViewPage(
              url: item?.url,
              title: item?.title,
            )),
      ),
    );
  }
}
