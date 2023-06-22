import 'package:flutter/foundation.dart';

class ModelEmployeeInfo extends ChangeNotifier {
  late String? _firstName;
  late String? _lastName;
  late String? _number;
  late String? _email;
  late String? _countryCode;
  late String? _address;
  late String? _business;
  late String? _password;
  late String? _UID;
  late bool? _isLoading = false;


  bool get isLoading => _isLoading!;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  static const firstNameKey = 'firstNameKey';
  static const lastNameKey = 'lastNameKey';
  static const numberKey = 'numberKey';
  static const emailKey = 'emailKey';
  static const countryCodeKey = 'CountryCodeKey';
  static const addressKey = 'addressKey';
  static const businessKey = 'businessKey';
  static const passwordKey = 'passwordKey';
  static const UIDKey = 'UIDKey';

  ModelEmployeeInfo({
     String? firstName,
     String? lastName,
     String? number,
     String? email,
     String? countryCode,
     String? address,
     String? business,
     String? password,
     String? UID,

  })
      : _firstName = firstName,
        _lastName = lastName,
        _number = number,
        _email = email,
        _countryCode = countryCode,
        _address = address,
        _business = business,
        _UID = UID,
        _password = password;

  Map<String, dynamic> toMap() {
    return {
      firstNameKey: firstName,
      lastNameKey: lastName,
      emailKey: email,
      numberKey: number,
      countryCodeKey: countryCode,
      addressKey: address,
      businessKey: business,
      passwordKey: password,
      UIDKey: UID
    };
  }

  String get countryCode => _countryCode!;

  set countryCode(String value) {
    _countryCode = value;
  }

  String get business => _business!;

  set business(String value) {
    _business = value;
  }

  String get UID => _UID!;

  set UID(String value) {
    _UID = value;
  }

  String get password => _password!;

  set password(String value) {
    _password = value;
  }

  String get address => _address!;

  set address(String value) {
    _address = value;
  }

  String get email => _email!;

  set email(String value) {
    _email = value;
  }

  String get number => _number!;

  set number(String value) {
    _number = value;
  }

  String get lastName => _lastName!;

  set lastName(String value) {
    _lastName = value;
  }

  String get firstName => _firstName!;

  set firstName(String value) {
    _firstName = value;
  }
}
