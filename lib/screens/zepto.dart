import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Zepto extends StatefulWidget {
  const Zepto({super.key});

  @override
  State<Zepto> createState() => _ZeptoState();
}

class _ZeptoState extends State<Zepto> {
  late WebViewController _webviewController;
  bool _loading = true;

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

            _simulateActions();
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
      ..loadRequest(Uri.parse('https://www.zeptonow.com/'));
  }

  void _simulateActions() async {
    // JavaScript to click the search button
    await _webviewController.runJavaScript(
        "document.querySelector('a[data-testid=\"search-bar-icon\"]').click();");

    // JavaScript to enter text and simulate Enter key press
    await _webviewController.runJavaScript(
        "const input = document.getElementById(':rn:--input');input.value = 'milk';input.dispatchEvent(new KeyboardEvent('keydown', {'key': 'Enter'}));");
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
        onPressed: () {},
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
