import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  const WebViewPage({required this.url, super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  int loadingPercentage = 0;
  late final WebViewController controller;
  FutureBuilder<String?>? pageTitle;
  Uri? _authCallback;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(
          'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.6668.81 Mobile Safari/537.36')
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (req) async {
          final uri = Uri.parse(req.url);
          if (uri.scheme == 'myapp') {
            setState(() {
              _authCallback = uri;
            });
            return NavigationDecision.prevent;
          } else {
            return NavigationDecision.navigate;
          }
        },
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
            pageTitle = FutureBuilder(
              future: controller.getTitle(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('${snapshot.data}');
                } else {
                  return const Text('Loading...');
                }
              },
            );
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..loadRequest(
        Uri.parse(widget.url),
        headers: {
          'ngrok-skip-browser-warning': '1',
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    if (_authCallback != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context, _authCallback!);
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: pageTitle,
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: controller,
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
            ),
        ],
      ),
    );
  }
}
