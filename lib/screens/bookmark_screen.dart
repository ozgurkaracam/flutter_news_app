import 'package:flutter/material.dart';
import 'package:flutter_news_app/screens/home_screen.dart';
import 'package:flutter_news_app/services/bookmark_service.dart';
import 'package:flutter_news_app/widgets/drawer_widget.dart';
import 'package:flutter_news_app/widgets/home/all_news.dart';
import 'package:iconly/iconly.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  List<bool> _likedMap = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const NewsAppTitle(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: BookmarkService().getbookmarks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: RefreshProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              _likedMap = List.generate(snapshot.data!.length, (index) => true);
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      HomeNewItem(newModel: snapshot.data![index]),
                      Positioned(
                          child: IconButton(
                        onPressed: () {
                          setState(() {
                            _likedMap[index] = !_likedMap[index];
                            print(_likedMap[index]);
                          });
                        },
                        icon: Icon(
                          _likedMap[index]
                              ? IconlyBold.bookmark
                              : IconlyLight.bookmark,
                        ),
                      ))
                    ],
                  );
                },
                itemCount: snapshot.data!.length,
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
