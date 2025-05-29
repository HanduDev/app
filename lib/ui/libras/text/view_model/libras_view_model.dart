import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LibrasViewModel extends ChangeNotifier {
  late final WebViewController webViewController = WebViewController();

  final TextEditingController textController = TextEditingController();

  void sendText() {
    String texto = textController.text;
    webViewController.runJavaScript("receberTexto('$texto');");
  }

  void setWebViewConfig() async {
    try {
      webViewController
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setUserAgent(
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36",
        );

      await webViewController.loadHtmlString(_generateHtml());

      await Future.delayed(Duration(seconds: 1));

      await webViewController.runJavaScript(
        "const btn = document.querySelector('.active');btn.click()",
      );
    } finally {}
  }

  String _generateHtml() {
    return '''
    <!DOCTYPE html>
    <html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>VLibras</title>
        <style>
          * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
          }

          .vw-plugin-wrapper {
            left: 0 !important;
            top: 0 !important;
            min-width: 100% !important;
            margin: 0 !important;
            border-radius: 0 !important;
          }

          .vpw-translator-button, .vpw-help-button, .vpw-controls, .vpw-box {
            display: none !important;
          }

          .vw-container {
            width: 100% !important;
            height: calc(100% + 80px) !important;
            min-width: 100% !important;
            transform: translate(10px, calc(-50% - 10px)) !important;
          }

          div[vp-rate-box] {
            display: none !important;
          }
        </style>
    </head>
   <body>
        <div vw class="enabled vw-container">
          <div vw-access-button class="active"></div>
          <div vw-plugin-wrapper class="vw-plugin-wrapper">
            <div class="vw-plugin-top-wrapper"></div>
          </div>
        </div>
        <script src="https://vlibras.gov.br/app/vlibras-plugin.js"></script>
        <script>
          new window.VLibras.Widget('https://vlibras.gov.br/app');

          window.receberTexto = function(texto) {
            const element = document.createElement('p');
            element.innerHTML = texto;

            document.body.appendChild(element);

            element.click();
            element.remove();
          }

          window.onerror = () => true
          window.alert = () => {}
        </script>
      </body>
    </html>''';
  }
}
