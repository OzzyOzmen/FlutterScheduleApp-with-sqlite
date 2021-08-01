class Event {
  int _eventId;
  String _eventCategory;
  String _eventDescription;
  String _eventDate;
  String _eventTime;
  String _eventStatus;
  int _userId;

  Event(this._eventDescription, this._eventCategory, this._eventDate,
      this._eventTime, this._eventStatus,this._userId);

  Event.byId(this._eventId, this._eventDescription, this._eventCategory,
      this._eventDate, this._eventStatus, this._eventTime,this._userId);

  int get eventId => _eventId;
  String get evetCategory => _eventCategory;
  String get eventDescription => _eventDescription;
  String get eventDate => _eventDate;
  String get eventTime => _eventTime;
  String get eventStatus => _eventStatus;
  int get userId => _userId;

  set evetCategory(String value) {
    if (evetCategory.length >= 2) {
      _eventCategory = value;
    }
  }

  set eventDascription(String value) {
    if (eventDescription.length >= 2) {
      _eventDescription = value;
    }
  }

  set eventDate(String value) {
    if (eventDate.length >= 2) {
      _eventDate = value;
    }
  }

  set eventTime(String value) {
    if (eventTime.length >= 2) {
      _eventTime = value;
    }
  }

  set eventStatus(String value) {
    if (eventStatus.length >= 2) {
      _eventStatus = value;
    }
  }

   set userId(int value) {
    if (userId > 0) {
      _userId = value;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["EventCategory"] = _eventCategory;
    map["EventDescription"] = _eventDescription;
    map["EventDate"] = _eventDate;
    map["EventTime"] = _eventTime;
    map["EventStatus"] = _eventStatus;
    map["UserId"] = _userId;
    if (_eventId != null) {
      map["EventId"] = _eventId;
    }
    return map;
  }

  Event.fromObject(dynamic o) {
    this._eventId = o["EventId"];
    this._eventCategory = o["EventCategory"];
    this._eventDescription = o["EventDescription"];
    this._eventDate = o["EventDate"];
    this._eventTime = o["EventTime"];
    this._eventStatus = o["EventStatus"];
    this._userId = o["UserId"];
  }
}
