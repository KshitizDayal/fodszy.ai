import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Blinkit extends StatefulWidget {
  const Blinkit({super.key});

  @override
  State<Blinkit> createState() => _BlinkitState();
}

class _BlinkitState extends State<Blinkit> {
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
      ..loadRequest(Uri.parse('https://blinkit.com/'));
  }

  // void _autoFillSearch() async {
  //   // Assuming the search input can be identified and manipulated directly
  //   await _webviewController.runJavaScript(
  //     "document.getElementsByClassName('SearchBar__PlaceholderContainer-sc-16lps2d-0')[0].click();",
  //   );
  //   await Future.delayed(
  //       Duration(seconds: 1)); // Give time for the search field to respond
  //   await _webviewController.runJavaScript(
  //       "document.querySelector('.SearchBarContainer__Input-sc-hl8pft-3').value = 'milk';");
  //   // _simulateEnterKeyPress();
  //   // Optionally, trigger an 'input' event if the website uses it to detect changes
  //   await _webviewController.runJavaScript('''
  //     var inputEvent = new Event('input', { bubbles: true });
  //     document.querySelector('.SearchBarContainer__Input-sc-hl8pft-3').dispatchEvent(inputEvent);
  //   ''');
  //   // Delay to ensure any JavaScript or animations have completed
  //   await Future.delayed(Duration(seconds: 1));
  // }}

  void _autoFillSearch() async {
    // Click to activate the search field
    await _webviewController.runJavaScript(
      "document.getElementsByClassName('SearchBar__PlaceholderContainer-sc-16lps2d-0')[0].click();",
    );
    await Future.delayed(
        Duration(seconds: 1)); // Give time for the search field to respond

    // Simulate typing 'milk'
    const searchTerm = 'milk';
    for (int i = 0; i <= searchTerm.length; i++) {
      String currentInput = searchTerm.substring(0, i);
      await _webviewController.runJavaScript(
          "document.querySelector('.SearchBarContainer__Input-sc-hl8pft-3').value = '$currentInput';");

      // Trigger input and keyup events
      await _webviewController.runJavaScript('''
      var inputField = document.querySelector('.SearchBarContainer__Input-sc-hl8pft-3');
      var inputEvent = new Event('input', { bubbles: true });
      var keyupEvent = new KeyboardEvent('keyup', { key: '${i < searchTerm.length ? searchTerm[i] : ''}', bubbles: true });
      inputField.dispatchEvent(inputEvent);
      inputField.dispatchEvent(keyupEvent);
    ''');

      // Short delay to mimic typing speed
      await Future.delayed(Duration(milliseconds: 100));
    }
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
