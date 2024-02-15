import 'package:flutter/material.dart';
import 'package:flutter_news_app/screens/home_screen.dart';
import 'package:flutter_news_app/screens/web_detail.dart';
import 'package:flutter_news_app/services/bookmark_service.dart';
import 'package:flutter_news_app/widgets/home/new_detail.dart';
import 'package:iconly/iconly.dart';

import '../models/new_model.dart';

// ignore: must_be_immutable
class NewDetailPage extends StatefulWidget {
  NewDetailPage({super.key, required this.newModel});
  NewModel newModel;

  @override
  State<NewDetailPage> createState() => _NewDetailPageState();
}

class _NewDetailPageState extends State<NewDetailPage> {
  late bool _inBookmarks = false;

  @override
  void initState() {
    _inBookmarkFunc();
    // TODO: implement initState
    super.initState();
  }

  Future<void> _inBookmarkFunc() async {
    _inBookmarks = await BookmarkService().inBookmarks(widget.newModel);
    setState(() {});
    print(_inBookmarks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const NewsAppTitle(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => WebDetail(
                        url: widget.newModel.url,
                      )));
            },
            icon: const Icon(IconlyBold.paper),
          ),
          IconButton(
            onPressed: () async {
              await BookmarkService().toggleBookmark(widget.newModel);
              await _inBookmarkFunc();
              setState(() {});
            },
            icon: _inBookmarks
                ? const Icon(IconlyBold.bookmark)
                : const Icon(IconlyLight.bookmark),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: NewDetail(
          newModel: widget.newModel,
        ),
      ),
    );
  }
}
