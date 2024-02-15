import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_news_app/models/new_model.dart';
import 'package:flutter_news_app/services/api_service.dart';
import 'package:flutter_news_app/widgets/home/all_news.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<String> words;
  late List<NewModel> news;
  late TextEditingController _te;
  late FocusNode _focusNode;
  bool _loading = false;
  @override
  void initState() {
    words = [
      "Javascript",
      "Dart",
      "Flutter",
      "Turkey",
      "Politics",
      "PHP",
      "England",
      "Election",
    ];
    news = [];
    _focusNode = FocusNode();
    _te = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    log("disposed");
    _focusNode.dispose();
    _te.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Listener(
          onPointerDown: (_) {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              CustomSearchBar(),
              Flexible(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: words
                            .where((w) => w
                                .toLowerCase()
                                .contains(_te.text.toLowerCase()))
                            .map(
                              (e) => InkWell(
                                onTap: () async {
                                  _loading = true;
                                  setState(() {});
                                  news = await APIService().fetchAll(q: e);
                                  setState(() {});
                                  _loading = false;
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(10),
                                  child: Text(
                                    e,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: _loading
                          ? const Center(child: RefreshProgressIndicator())
                          : ListView.builder(
                              itemBuilder: (context, index) {
                                return HomeNewItem(newModel: news[index]);
                              },
                              itemCount: news.length,
                            ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CustomSearchBar() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        Expanded(
          child: TextFormField(
            onChanged: (_) {
              setState(() {});
            },
            controller: _te,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: _complete,
                icon: const Icon(
                  Icons.search,
                ),
              ),
            ),
            focusNode: _focusNode,
            onEditingComplete: _complete,
          ),
        ),
      ],
    );
  }

  void _complete() async {
    news = await APIService().fetchAll(q: _te.text);
    _te.clear();
    _focusNode.unfocus();

    // _fetchNews(text: _te.text);
  }

  void _fetchNews({required String text}) async {
    log(text);
    setState(() {});
  }
}
