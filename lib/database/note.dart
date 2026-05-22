class Note {
  int? _id;
  String? _title;
  String? _description;
  int? _priority;
  String? _date;

  // Parameterized constructor
  Note(this._title, this._description, this._priority, this._date);

  // named constructor
  Note.withId(
    this._id,
    this._title,
    this._description,
    this._priority,
    this._date,
  );

  // getter method of code
  int? get id => _id;
  String? get title => _title;
  String? get description => _description;
  int? get priority => _priority;
  String? get date => _date;

  // setter method of code
  set title(String newtitle) {
    if (newtitle.length <= 255) {
      _title = newtitle;
    }
  }

  set description(String? newDescription) {
    _description = newDescription ?? "";
  }

  set date(String newDate) {
    _date = newDate;
  }

  set priority(int? newPriority) {
    _priority = newPriority ?? 2;
  }

  // convert note object in to map object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;

    return map;
  }

  // extract map objext to note object
  Note.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _title = map['title'];
    _description = map['description'];
    _priority = map['priority'];
    _date = map['date'];
  }
}
