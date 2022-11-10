class ModelServicesPhotosAndVideos {
  String? _url;

  ModelServicesPhotosAndVideos({required String url}) : _url = url;

  String get url => _url!;

  set url(String value) {
    _url = value;
  }

  static const String urlKey = 'urlKey';

  Map<String, dynamic> toMap() {
    return {urlKey: url};
  }
}
