import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../search_modal.dart';

class Blinkit extends StatefulWidget {
  const Blinkit({super.key});

  @override
  State<Blinkit> createState() => _BlinkitState();
}

class _BlinkitState extends State<Blinkit> {
  late WebViewController _webviewController;
  bool _loading = true;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _webviewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            const Center(
              child: CircularProgressIndicator(),
            );
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              _loading = false;
            });
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://blinkit.com/'));
  }

  void _searchForQuery(String query) {
    final searchUrl = Uri.encodeFull('https://www.blinkit.com/search?q=$query');
    _webviewController.loadRequest(Uri.parse(searchUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Fodzsy.Ai"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSearchModal(
            searchQuery: () => _searchForQuery(searchController.text),
            context: context,
            searchController: searchController,
          );
        },
        child: const Text("AI"),
      ),
      body: Stack(children: [
        WebViewWidget(controller: _webviewController),
        if (_loading) const Center(child: CircularProgressIndicator())
      ]),
    );
  }

  Widget openAIassistant() {
    return Container();
  }
}
