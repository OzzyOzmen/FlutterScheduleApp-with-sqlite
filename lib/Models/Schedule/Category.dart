class Category {
  int _categoryId;
  String _categoryName;

  Category(this._categoryName);

  Category.byId(this._categoryId,this._categoryName);

  int get categoryId => _categoryId;
  String get categoryName => _categoryName;

  set categoryName(String value) {
    if (categoryName.length >= 2) {
      _categoryName = value;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["CategoryName"] = _categoryName;
    if (_categoryId != null) {
      map["CategoryId"] = _categoryId;
    }
    return map;
  }

  Category.fromObject(dynamic o) {
    this._categoryId = o["CategoryId"];
    this._categoryName = o["CategoryName"];
  }
}
