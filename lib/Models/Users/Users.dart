class Users {
  int _userId;
  String _userName;
  String _userPassword;
  String _userFullName;
  String _userDayOfBirth;
  String _userPhoneNumber;
  String _userEmail;
  String _userGender;
  String _userPhoto;
  String _userStatus;

  Users(
      this._userName,
      this._userPassword,
      this._userFullName,
      this._userDayOfBirth,
      this._userPhoneNumber,
      this._userEmail,
      this._userGender,
      this._userPhoto,
      this._userStatus);

  Users.byId(
      this._userId,
      this._userName,
      this._userPassword,
      this._userFullName,
      this._userDayOfBirth,
      this._userPhoneNumber,
      this._userEmail,
      this._userGender,
      this._userPhoto,
      this._userStatus);

  int get userId => _userId;
  String get userName => _userName;
  String get userPassword => _userPassword;
  String get userFullName => _userFullName;
  String get userDayOfBirth => _userDayOfBirth;
  String get userPhoneNumber => _userPhoneNumber;
  String get userEmail => _userEmail;
  String get userGender => _userGender;
  String get userPhoto => _userPhoto;
  String get userStatus => _userStatus;

  set userName(String value) {
    if (userName.length >= 2) {
      _userName = value;
    }
  }

  set userPassword(String value) {
    if (userPassword.length >= 2) {
      _userPassword = value;
    }
  }

  set userFullName(String value) {
    if (userFullName.length >= 2) {
      _userFullName = value;
    }
  }

  set userDayOfBirth(String value) {
    if (userDayOfBirth.length >= 2) {
      _userDayOfBirth = value;
    }
  }

  set userPhoneNumber(String value) {
    if (userPhoneNumber.length >= 2) {
      _userPhoneNumber = value;
    }
  }

  set userEmail(String value) {
    if (userEmail.length >= 2) {
      _userEmail = value;
    }
  }

  set userGender(String value) {
    if (userGender.length >= 2) {
      _userGender = value;
    }
  }

  set userPhoto(String value) {
    if (userPhoto.length >= 2) {
      _userPhoto = value;
    }
  }

  set userStatus(String value) {
    if (userStatus.length >= 2) {
      _userStatus = value;
    }
  }

  // Map oluşturuyoruz

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["UserName"] = _userName;
    map["UserPassword"] = _userPassword;
    map["UserFullName"] = _userFullName;
    map["UserDayOfBirth"] = _userDayOfBirth;
    map["UserPhoneNumber"] = _userPhoneNumber;
    map["UserEmail"] = _userEmail;
    map["UserGender"] = _userGender;
    map["UserPhoto"] = _userPhoto;
    map["UserStatus"] = _userStatus;
    if (_userId != null) {
      map["UserId"] = _userId;
    }
    return map;
  }

  Users.fromObject(dynamic o) {
    this._userId = o["UserId"];
    this._userName = o["UserName"];
    this._userPassword = o["UserPassword"];
    this._userFullName = o["UserFullName"];
    this._userDayOfBirth = o["UserDayOfBirth"];
    this._userPhoneNumber = o["UserPhoneNumber"];
    this._userEmail = o["UserEmail"];
    this._userGender = o["UserGender"];
    this._userPhoto = o["UserPhoto"];
    this._userStatus = o["UserStatus"];
  }
}
