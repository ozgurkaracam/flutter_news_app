import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/screens/new_detail_page.dart';
import 'package:flutter_news_app/services/api_service.dart';
import 'package:flutter_news_app/widgets/home/new_detail.dart';

class TopTrending extends StatefulWidget {
  const TopTrending({super.key});

  @override
  State<TopTrending> createState() => _TopTrendingState();
}

class _TopTrendingState extends State<TopTrending> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: APIService().getTopHeadlines(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return Swiper(
            layout: SwiperLayout.STACK,
            itemWidth: MediaQuery.of(context).size.width * 0.9,
            viewportFraction: 0.9,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (ctx) =>
                            NewDetailPage(newModel: snapshot.data![index])),
                  );
                },
                child: Container(
                    color: Colors.transparent,
                    child: NewDetail(
                      newModel: snapshot.data![index],
                    )),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        return const Center(
          child: Text("TEST"),
        );
      },
    );
  }
}
