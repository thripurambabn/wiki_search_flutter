import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WikiWebView extends StatefulWidget {
  final String url;

  const WikiWebView({
    super.key,
    required this.url,
  });

  @override
  State<WikiWebView> createState() => _WikiWebViewState();
}

class _WikiWebViewState extends State<WikiWebView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(widget.url),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
