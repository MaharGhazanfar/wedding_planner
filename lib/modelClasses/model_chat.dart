class ModelChat {
  late String _msg;
  late String _receiverName;
  late String _senderNumber;
  late String _receiverNumber;
  late String _url;
  late String _senderStatus;
  late String _isSendByMe;
  late String _receiverStatus;
  late String _sendingTime;
  late String _deliveryTime;

  static const msgKey = 'msgKey';
  static const receiverNameKey = 'receiverNameKey';
  static const isSendByMeKey = 'isSendByMeKey ';
  static const senderStatusKey = 'senderStatusKey';
  static const receiverStatusKey = 'receiverStatusKey';
  static const senderNumberKey = 'senderNumberKey';
  static const receiverNumberKey = 'receiverNumberKey';
  static const URLKey = 'URLKey';
  static const sendingTimeKey = 'sendingTimeKey';
  static const deliveryTimeKey = 'deliveryTimeKey';

  ModelChat({
    required String msg,
    required String sendingNumber,
    required String receiverName,
    required String isSendByMe,

    required String senderStatus,
    required String receiverStatus,
    required String receiverNumber,
    required String URL,
    required String sendingTime,
    required String deliveryTime,
  })  : _msg = msg,
        _senderNumber = sendingNumber,
        _senderStatus = senderStatus,
        _isSendByMe = isSendByMe,
        _receiverStatus = receiverStatus,
        _receiverNumber = receiverNumber,
        _receiverName = receiverName,
        _url = URL,
        _sendingTime = sendingTime,
        _deliveryTime = deliveryTime;

  Map<String, dynamic> toMap() {
    return {
      msgKey: msg,
      senderNumberKey: senderNumber,
      senderStatusKey : senderStatus,
      isSendByMeKey : isSendByMe,
      receiverStatusKey : receiverStatus,
      receiverNameKey: receiverName,
      URLKey: URL,
      receiverNumberKey: receiverNumber,
      sendingTimeKey: sendingTime,
      deliveryTimeKey: deliveryTime
    };
  }


  String get isSendByMe => _isSendByMe;

  set isSendByMe(String value) {
    _isSendByMe = value;
  }

  String get senderStatus => _senderStatus;

  set senderStatus(String value) {
    _senderStatus = value;
  }



  String get receiverName => _receiverName;

  set receiverName(String value) {
    _receiverName = value;
  }

  String get deliveryTime => _deliveryTime;

  set deliveryTime(String value) {
    _deliveryTime = value;
  }

  String get sendingTime => _sendingTime;

  set sendingTime(String value) {
    _sendingTime = value;
  }

  String get URL => _url;

  set URL(String value) {
    _url = value;
  }

  String get receiverNumber => _receiverNumber;

  set receiverNumber(String value) {
    _receiverNumber = value;
  }

  String get senderNumber => _senderNumber;

  set senderNumber(String value) {
    _senderNumber = value;
  }

  String get msg => _msg;

  set msg(String value) {
    _msg = value;
  }

  String get receiverStatus => _receiverStatus;

  set receiverStatus(String value) {
    _receiverStatus = value;
  }
}
