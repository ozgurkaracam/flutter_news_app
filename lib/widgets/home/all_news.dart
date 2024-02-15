import 'package:flutter/material.dart';
import 'package:flutter_news_app/models/new_model.dart';
import 'package:flutter_news_app/screens/new_detail_page.dart';
import 'package:flutter_news_app/services/api_service.dart';

class AllNews extends StatefulWidget {
  const AllNews({super.key});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  int currentPageIndex = 1;
  final ScrollController _listViewController = ScrollController();

  @override
  void initState() {
    _listViewController.addListener(() {
      if (_listViewController.position.pixels ==
          _listViewController.position.maxScrollExtent) {
        currentPageIndex++;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: APIService().fetchAll(page: currentPageIndex),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.active) {
          return const Center(
            child: Text("HATA!"),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => setState(() {
                    if (currentPageIndex != 1) currentPageIndex--;
                  }),
                  iconSize: 30,
                  icon: const Icon(Icons.skip_previous),
                ),
                Flexible(
                  child: SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return TextButton(
                          style: currentPageIndex == index + 1
                              ? ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                )
                              : const ButtonStyle(),
                          onPressed: () {
                            setState(() {
                              currentPageIndex = index + 1;
                            });
                          },
                          child: Text(
                            (index + 1).toString(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => setState(() {
                    currentPageIndex++;
                  }),
                  iconSize: 30,
                  icon: const Icon(Icons.skip_next_sharp),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: snapshot.data!.isNotEmpty
                  ? RefreshIndicator(
                      semanticsValue: "SEMANTICS VALUE",
                      semanticsLabel: "HAHAHAHAH",
                      edgeOffset: 10,
                      triggerMode: RefreshIndicatorTriggerMode.anywhere,
                      onRefresh: () async {
                        setState(() {});
                      },
                      child: ListView.builder(
                        controller: _listViewController,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          NewModel newModel = snapshot.data![index];
                          return HomeNewItem(newModel: newModel);
                        },
                      ),
                    )
                  : Container(),
            ),
          ],
        );
      },
    );
  }
}

Container showLine() {
  return Container(
    color: Colors.blue,
    height: 50,
    width: 50,
  );
}

// ignore: must_be_immutable
class HomeNewItem extends StatelessWidget {
  HomeNewItem({super.key, required this.newModel});
  NewModel newModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NewDetailPage(
                  newModel: newModel,
                )));
      },
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: showLine(),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: showLine(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 180,
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                      newModel.urlToImage,
                      width: 100,
                      errorBuilder: (context, error, stackTrace) => Container(),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            newModel.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            newModel.author,
                            maxLines: 1,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(Icons.link),
                                Text(newModel.publishedAt)
                              ]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
