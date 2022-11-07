import 'package:shared_preferences/shared_preferences.dart';

class PersonalLoginInfo {
  late String _firstName;
  late String _lastName;
  late String _number;
  late String _business;
  late String _categories;
  late String _location;

  static SharedPreferences? prefs;

  static const firstNameKey = 'firstNameKey';
  static const lastNameKey = 'lastNameKey';
  static const numberKey = 'numberKey';
  static const businessKey = 'businessKey';
  static const categoryKey = 'categoryKey';
  static const locationKey = 'locationKey';

  PersonalLoginInfo({
    required String firstName,
    required String lastName,
    required String number,
    required String business,
    required String category,
    required String location,
  })  : _firstName = firstName,
        _lastName = lastName,
        _number = number,
        _business = business,
        _categories = category,
        _location = location;

  Map<String, dynamic> toMap() {
    return {
      firstNameKey: firstName,
      lastNameKey: lastName,
      businessKey: business,
      numberKey: number,
      categoryKey: categories,
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
