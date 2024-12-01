import 'package:flutter_test/flutter_test.dart';

class UrlUtils {
  static bool isValidUrl(String url) {
    final Uri? uri = Uri.tryParse(url);
    return uri != null && uri.isAbsolute && uri.hasScheme && uri.host.isNotEmpty;
  }
}

void main() {
  test('UrlUtils.isValidUrl - Validate URL Format', () {
    expect(UrlUtils.isValidUrl('https://example.com'), isTrue);
    expect(UrlUtils.isValidUrl('http://example.com'), isTrue);
    expect(UrlUtils.isValidUrl('not-a-valid-url'), isFalse);
    expect(UrlUtils.isValidUrl('ftp://example.com'), isTrue);
    expect(UrlUtils.isValidUrl('example.com'), isFalse);
  });
}
