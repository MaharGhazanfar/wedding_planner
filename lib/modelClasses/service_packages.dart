class ModelServicePackages {
  late String _offerName;
  late double _price;
  late double _discount;
  late String _categories;
  late String _location;
  late String _imageURL;
  late String _description;

  static const offerNameKey = 'offerNameKey';
  static const priceKey = 'priceKey';
  static const discountKey = 'discountKey';
  static const descriptionKey = 'descriptionKey';
  static const categoryKey = 'categoryKey';
  static const locationKey = 'locationKey';
  static const imageURLKey = 'imageURLKey';

  ModelServicePackages({
    required String offerName,
    required double price,
    required double discount,
    required String category,
    required String description,
    required String imageURL,
    required String location,
  })  : _offerName = offerName,
        _price = price,
        _discount = discount,
        _description =description,
        _categories = category,
        _imageURL = imageURL,
        _location = location;

  String get imageURL => _imageURL;

  set imageURL(String value) {
    _imageURL = value;
  }


  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get location => _location;

  set location(String value) {
    _location = value;
  }

  String get categories => _categories;

  set categories(String value) {
    _categories = value;
  }

  double get discount => _discount;

  set discount(double value) {
    _discount = value;
  }

  double get price => _price;

  set price(double value) {
    _price = value;
  }

  String get offerName => _offerName;

  set offerName(String value) {
    _offerName = value;
  }

  Map<String, dynamic> toMap() {
    return {
      offerNameKey: offerName,
      priceKey: price,
      discountKey: discount,
      imageURLKey: imageURL,
      categoryKey: categories,
      locationKey: location,
      descriptionKey: description
    };
  }
}
