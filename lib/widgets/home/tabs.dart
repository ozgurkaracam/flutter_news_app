import 'package:flutter/material.dart';
import 'package:flutter_news_app/screens/home_screen.dart';
import 'package:flutter_news_app/widgets/home/tab_item.dart';

// ignore: must_be_immutable
class Tabs extends StatefulWidget {
  Tabs({super.key, required this.selectedPage});
  TabType selectedPage;
  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TabItem(
          title: "All News",
          selected: widget.selectedPage == TabType.allNews ? true : false,
          callback: () {
            setState(() {
              widget.selectedPage = TabType.allNews;
            });
          },
        ),
        const SizedBox(
          width: 10,
        ),
        TabItem(
          title: "Top Trending",
          selected: widget.selectedPage == TabType.topTrending ? true : false,
          callback: () {
            setState(() {
              widget.selectedPage = TabType.topTrending;
            });
          },
        ),
      ],
    );
  }
}
