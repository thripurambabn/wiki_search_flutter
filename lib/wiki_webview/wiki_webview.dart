import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WikiWebView extends StatefulWidget {
  final String url;

  const WikiWebView({super.key, 
    required this.url,
  });

  @override
  State<WikiWebView> createState() => _WikiWebViewState();
}

class _WikiWebViewState extends State<WikiWebView> {
 // Completer<WebViewController> _controller = Completer<WebViewController>();
  bool _isLoading = false;
 

  @override
  Widget build(BuildContext context) {
     var webViewController= WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
     onPageStarted: (val) {
          if (!_isLoading) {
            setState(() {
              _isLoading = true;
            });
          }
        },
       onPageFinished: (val) {
          if (_isLoading) {
            setState(() {
              _isLoading = false;
            });
          }
        },
      
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
        if (request.url.startsWith(widget.url)) {
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    ),
  )
  ..loadRequest(Uri.parse('https://flutter.dev'));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent[100],
        title:const Text(
          "WikiSearch",
        ),
      ),
      body:
      WebViewWidget(controller: webViewController),
     
    );
  }
}
