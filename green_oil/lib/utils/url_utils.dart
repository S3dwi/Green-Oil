class UrlUtils {
  static bool isValidUrl(String? url) {
    return url != null && Uri.tryParse(url)?.hasAbsolutePath == true;
  }
}
