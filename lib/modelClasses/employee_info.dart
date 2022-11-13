class ModelEmployeeInfo {
  late String _firstName;
  late String _lastName;
  late String _number;
  late String _email;
  late String _address;
  late String _business;
  late String _password;
  late String _UID;

  static const firstNameKey = 'firstNameKey';
  static const lastNameKey = 'lastNameKey';
  static const numberKey = 'numberKey';
  static const emailKey = 'emailKey';
  static const addressKey = 'addressKey';
  static const businessKey = 'businessKey';
  static const passwordKey = 'passwordKey';
  static const UIDKey = 'UIDKey';

  ModelEmployeeInfo({
    required String firstName,
    required String lastName,
    required String number,
    required String email,
    required String address,
    required String business,
    required String password,
    required String UID,
  })  : _firstName = firstName,
        _lastName = lastName,
        _number = number,
        _email = email,
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
      addressKey: address,
      businessKey : business,
      passwordKey: password,
      UIDKey: UID
    };
  }


  String get business => _business;

  set business(String value) {
    _business = value;
  }

  String get UID => _UID;

  set UID(String value) {
    _UID = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
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
