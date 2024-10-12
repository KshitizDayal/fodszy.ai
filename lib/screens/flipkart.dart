import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Flipkart extends StatefulWidget {
  const Flipkart({super.key});

  @override
  State<Flipkart> createState() => _FlipkartState();
}

class _FlipkartState extends State<Flipkart> {
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

            _autoFillSearch();
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
      ..loadRequest(Uri.parse('https://www.flipkart.com/'));
  }

  void _autoFillSearch() async {
    // JavaScript to click the search area or button if applicable
    await _webviewController.runJavaScript(
        "document.querySelector('div[class*=\"css-1rynq56\"]').click();");

    // Give the page a moment to respond to the click
    await Future.delayed(Duration(seconds: 1));

    // await _webviewController.runJavaScript(
    //     "document.querySelector('a[class*=\"_1je_xh\"]').click();");

    // await Future.delayed(Duration(seconds: 1));

    // Enter 'iphone' in the search bar
    await _webviewController.runJavaScript("""
      const inputField = document.querySelector('input[type=\"search\"]');
      inputField.value = 'iphone';
      inputField.dispatchEvent(new Event('input', { bubbles: true }));
      document.querySelector('form').submit(); 
    """);
    await Future.delayed(Duration(seconds: 1));

    // Trigger the form submission by simulating an Enter key press
    // await _webviewController.runJavaScript(
    //     "searchBar.dispatchEvent(new KeyboardEvent('keypress', {'key': 'Enter'}));");
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
}
