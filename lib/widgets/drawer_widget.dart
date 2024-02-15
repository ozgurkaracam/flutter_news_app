import 'package:flutter/material.dart';
import 'package:flutter_news_app/screens/home_screen.dart';
import 'package:flutter_news_app/screens/bookmark_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Drawer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(80.0),
              child: Image.asset("assets/newspaper.png"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Column(
                children: [
                  listTile(Icons.home, "Home", () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (c) => const Home()));
                  }),
                  listTile(Icons.bookmark, "Bookmarks", () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (c) => const BookmarkScreen()));
                  }),
                  const SizedBox(
                    height: 40,
                  ),
                  SwitchListTile(
                    value: false,
                    onChanged: (val) {},
                    title: const Text("Dark Mode"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget listTile(IconData icon, String title, VoidCallback callback) {
    return GestureDetector(
      onTap: callback,
      child: ListTile(
        leading: Icon(
          icon,
          size: 40,
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
