String? extractYoutubeId(String url) {
  final uri = Uri.tryParse(url);
  if (uri == null) return null;
  if (uri.host.contains('youtu.be'))
    return uri.pathSegments.isNotEmpty
        ? uri.pathSegments.first : null;
  if (uri.host.contains('youtube.com'))
    return uri.queryParameters['v'];
  return null;
}
