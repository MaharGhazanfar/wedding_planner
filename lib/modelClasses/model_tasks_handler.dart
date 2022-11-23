class ModelTasksHandler {
  late String _toDO;
  late String _dateTime;
  late bool _reminder;
  late String _category;
  late String _notes;
  bool _isSelected;

  static const toDOKey = 'toDOKey';
  static const dateTimeKey = 'dateTimeKey';
  static const reminderKey = 'reminderKey';
  static const categoryKey = 'categoryKey';
  static const notesKey = 'notesKey';
  static const selectedKey = 'selectedKey';

  ModelTasksHandler({
    required String toDO,
    required String dateTime,
    bool reminder = false,
    required String category,
    required String notes,
    bool isSelected = false,
  })  : _toDO = toDO,
        _dateTime = dateTime,
        _reminder = reminder,
        _category = category,
        _notes = notes,
        _isSelected = isSelected;

  String get notes => _notes;

  set notes(String value) {
    _notes = value;
  }

  String get category => _category;

  set category(String value) {
    _category = value;
  }

  bool get reminder => _reminder;

  set reminder(bool value) {
    _reminder = value;
  }

  String get dateTime => _dateTime;

  set dateTime(String value) {
    _dateTime = value;
  }

  String get toDO => _toDO;

  set toDO(String value) {
    _toDO = value;
  }

  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    _isSelected = value;
  }

  Map<String, dynamic> toMap() {
    return {
      toDOKey: toDO,
      dateTimeKey: dateTime,
      reminderKey: reminder,
      categoryKey: category,
      notesKey: notes,
      selectedKey: isSelected
    };
  }
}
