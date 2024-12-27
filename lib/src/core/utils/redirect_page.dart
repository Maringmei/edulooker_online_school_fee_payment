import 'dart:html' as html;

/// Opens the specified [url] in a new browser tab.
void redirectToNewTab(String url) {
  html.window.open(url, '_blank'); // '_blank' opens the URL in a new tab
}
