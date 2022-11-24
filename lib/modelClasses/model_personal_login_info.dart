import 'package:shared_preferences/shared_preferences.dart';

class ModelPersonalLoginInfo {
  late String _firstName;
  late String _lastName;
  late String _countryCode;
  late String _number;
  late String _business;
  late String _categories;
  late String _location;
  late String _imageUrl;

  String get countryCode => _countryCode;

  set countryCode(String value) {
    _countryCode = value;
  }

  String get imageUrl => _imageUrl;

  set imageUrl(String value) {
    _imageUrl = value;
  }

  static SharedPreferences? prefs;

  static const firstNameKey = 'firstNameKey';
  static const lastNameKey = 'lastNameKey';
  static const numberKey = 'numberKey';
  static const imgUrlKey = 'ImageUrl';
  static const countryCodeKey = 'CountryCodeKey';
  static const businessKey = 'businessKey';
  static const categoryKey = 'categoryKey';
  static const locationKey = 'locationKey';

  ModelPersonalLoginInfo({
    required String firstName,
    required String lastName,
    required String number,
    required String countryCode,
    required String business,
    required String imgUrl,
    required String category,
    required String location,
  })
      : _firstName = firstName,
        _lastName = lastName,
        _number = number,
        _imageUrl = imgUrl,
        _countryCode = countryCode,
        _business = business,
        _categories = category,
        _location = location;

  Map<String, dynamic> toMapForProvider() {
    return {
      firstNameKey: firstName,
      lastNameKey: lastName,
      businessKey: business,
      numberKey: number,
      countryCodeKey: countryCode,
      imgUrlKey: imageUrl,
      categoryKey: categories,
      locationKey: location
    };
  }

  Map<String, dynamic> toMapForUser() {
    return {
      firstNameKey: firstName,
      lastNameKey: lastName,
      numberKey: number,
      countryCodeKey: countryCode,
      imgUrlKey: imageUrl,
      locationKey: location
    };
  }

  String get location => _location;

  set location(String value) {
    _location = value;
  }

  String get categories => _categories;

  set categories(String value) {
    _categories = value;
  }

  String get business => _business;

  set business(String value) {
    _business = value;
  }

  String get number => _number;

  set number(String value) {
    _number = value;
  }

  String get lastName => _lastName;

  set lastName(String value) {
    _lastName = value;
  }

  String get firstName => _firstName;

  set firstName(String value) {
    _firstName = value;
  }
}
