class Task {
  
  int _taskId;
  String _taskCategory;
  String _taskTitle;
  String _taskDescription;
  String _taskDate;
  String _taskStatus;
  int _userId;

  Task(this._taskCategory, this._taskTitle, this._taskDescription,
      this._taskDate, this._taskStatus, this._userId);

  Task.byId(this._taskId,this._taskCategory, this._taskTitle,
      this._taskDescription, this._taskDate, this._taskStatus,this._userId);

  int get taskId => _taskId;
  String get taskCategory => _taskCategory;
  String get taskTitle => _taskTitle;
  String get taskDescription => _taskDescription;
  String get taskDate => _taskDate;
  String get taskStatus => _taskStatus;
  int get userId =>_userId;

  set taskCategory(String value) {
    if (taskCategory.length >= 2) {
      _taskCategory = value;
    }
  }

  set taskTitle(String value) {
    if (taskTitle.length >= 2) {
      _taskTitle = value;
    }
  }

  set taskDescription(String value) {
    if (taskDescription.length >= 2) {
      _taskDescription = value;
    }
  }

  set taskDate(String value) {
    if (taskDate.length >=2) {
      _taskDate = value;
    }
  }

  set taskStatus(String value) {
    if (taskStatus.length >= 2) {
      _taskStatus = value;
    }
  }

  set userId(int value) {
    if (userId > 0) {
      _userId = value;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["TaskTitle"] = _taskTitle;
    map["TaskCategory"] = _taskCategory;
    map["TaskDescription"] = _taskDescription;
    map["TaskDate"] = _taskDate;
    map["TaskStatus"] = _taskStatus;
    map["UserId"] = _userId;
    if (_taskId != null) {
      map["taskId"] = _taskId;
    }
    return map;
  }

  Task.fromObject(dynamic o) {
    this._taskId = o["TaskId"];
    this._taskCategory = o["TaskCategory"];
    this._taskTitle = o["TaskTitle"];
    this._taskDescription = o["TaskDescription"];
    this._taskDate = o["TaskDate"];
    this._taskStatus = o["TaskStatus"];
    this._userId = o["UserId"];
  }
}
