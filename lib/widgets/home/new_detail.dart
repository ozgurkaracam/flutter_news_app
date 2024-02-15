import 'package:flutter/material.dart';
import 'package:flutter_news_app/models/new_model.dart';

// ignore: must_be_immutable
class NewDetail extends StatelessWidget {
  NewDetail({super.key, required this.newModel});

  NewModel newModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Image.network(
              newModel.urlToImage,
              height: 200,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.white,
                height: 200,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            height: 500,
            child: Column(
              children: [
                Text(
                  newModel.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(newModel.description),
                const SizedBox(
                  height: 30,
                ),
                const Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: [
                      Text("15 Mins"),
                      Text("20/10/2023"),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
