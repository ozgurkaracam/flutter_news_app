import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class WebDetail extends StatefulWidget {
  WebDetail({super.key, required this.url});

  String url;

  @override
  State<WebDetail> createState() => _WebDetailState();
}

class _WebDetailState extends State<WebDetail> {
  int _progress = 0;
  late WebViewController _webViewController;

  @override
  void initState() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000));
    _webViewController.loadRequest(Uri.parse(widget.url));
    _webViewController.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          _progress = progress;

          setState(() {});
        },
        onWebResourceError: (WebResourceError error) {},
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.url),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 30, bottom: 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _showDivider(),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "More Options...",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                moreButton(
                                  callback: () {
                                    _webViewController.reload();
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icons.refresh,
                                  title: "Reload Page",
                                ),
                                moreButton(
                                  callback: () async {
                                    await Share.share(widget.url);
                                  },
                                  icon: Icons.share,
                                  title: "Share",
                                ),
                                moreButton(
                                  callback: () async {
                                    Uri url = Uri.parse(widget.url);
                                    if (!await launchUrl(url)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                  icon: Icons.open_in_browser_outlined,
                                  title: "Open In Browser",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              icon: const Icon(IconlyBroken.more_circle))
        ],
      ),
      body: _progress > 30
          ? WebViewWidget(
              controller: _webViewController,
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  InkWell moreButton(
      {required VoidCallback callback,
      required IconData icon,
      required String title}) {
    return InkWell(
      onTap: callback,
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  SizedBox _showDivider() {
    return const SizedBox(
      width: 70,
      child: Divider(
        thickness: 5,
      ),
    );
  }
}
