class LmsCategory {
  late int _id, _parent, _sortorder, _coursecount;
  late int _visible, _visibleold, _timemodified, _depth;
  late String _name, _idnumber, _description, _descriptionformat, _path, _theme;

  LmsCategory(
      this._id,
      this._name,
      this._idnumber,
      this._description,
      this._descriptionformat,
      this._parent,
      this._sortorder,
      this._coursecount,
      this._visible,
      this._visibleold,
      this._timemodified,
      this._depth,
      this._path,
      this._theme);

  int get id => _id;
  String get name => _name;
  String get idnumber => _idnumber;
  String get description => _description;
  String get descriptionformat => _descriptionformat;
  int get parent => _parent;
  int get sortorder => _sortorder;
  int get coursecount => _coursecount;
  int get visible => _visible;
  int get visibleold => _visibleold;
  int get timemodified => _timemodified;
  int get depth => _depth;
  String get path => _path;
  String get theme => _theme;

  set id(int isId) {
    this._id = isId;
  }

  set name(String isName) {
    this._name = isName;
  }

  set idnumber(String isIdnumber) {
    this._idnumber = isIdnumber;
  }

  set description(String newDescription) {
    if (newDescription.length <= 10) {
      this._description = newDescription;
    }
  }

  set descriptionformat(String newDescriptionformat) {
    this._descriptionformat = newDescriptionformat;
  }

  set parent(int newParent) {
    this._parent = newParent;
  }

  set sortorder(int newSortorder) {
    this._sortorder = newSortorder;
  }

  set coursecount(int newCoursecount) {
    this._coursecount = newCoursecount;
  }

  set visible(int newVisible) {
    this._visible = newVisible;
  }

  set visibleold(int newVisibleold) {
    this._visibleold = newVisibleold;
  }

  set timemodified(int newTimemodified) {
    this._timemodified = newTimemodified;
  }

  set depth(int newDepth) {
    this._depth = newDepth;
  }

  set path(String newPath) {
    this._path = newPath;
  }

  set theme(String newTheme) {
    this._theme = newTheme;
  }

  // Convert a LmsCategory object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = _id;
    map['name'] = _name;
    map['idnumber'] = _idnumber;
    map['description'] = _description;
    map['descriptionformat'] = _descriptionformat;
    map['parent'] = _parent;
    map['sortorder'] = _sortorder;
    map['coursecount'] = _coursecount;
    map['visible'] = _visible;
    map['visibleold'] = _visibleold;
    map['timemodified'] = _timemodified;
    map['depth'] = _depth;
    map['path'] = _path;
    map['theme'] = _theme;
    return map;
  }

  // Extract a LmsCategory object from a Map object
  LmsCategory.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._idnumber = map['idnumber'];
    this._description = map['description'];
    this._descriptionformat = map['descriptionformat'];
    this._parent = map['parent'];
    this._sortorder = map['sortorder'];
    this._coursecount = map['coursecount'];
    this._visible = map['visible'];
    this._visibleold = map['visibleold'];
    this._timemodified = map['timemodified'];
    this._depth = map['depth'];
    this._path = map['path'];
    this._theme = map['theme'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['idnumber'] = idnumber;
    data['description'] = description;
    data['descriptionformat'] = descriptionformat;
    data['parent'] = parent;
    data['sortorder'] = sortorder;
    data['coursecount'] = coursecount;
    data['visible'] = visible;
    data['visibleold'] = visibleold;
    data['timemodified'] = timemodified;
    data['depth'] = depth;
    data['path'] = path;
    data['theme'] = theme;
    return data;
  }

  LmsCategory.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.idnumber = json['idnumber'];
    this.description = json['description'];
    this.descriptionformat = json['descriptionformat'];
    this.parent = json['parent'];
    this.sortorder = json['sortorder'];
    this.coursecount = json['coursecount'];
    this.visible = json['visible'];
    this.visibleold = json['visibleold'];
    this.timemodified = json['timemodified'];
    this.depth = json['depth'];
    this.path = json['path'];
    this.theme = json['theme'];
  }
}
