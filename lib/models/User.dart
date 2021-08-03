class User extends Object {
  String username;
  String firstname;
  String? lastname;
  String? lang;
  int userid;
  String? userpictureurl;

  User(
      {required this.username,
      required this.firstname,
      this.lastname,
      this.lang,
      required this.userid,
      this.userpictureurl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['username'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        userid: json['userid'],
        lang: json['lang'],
        userpictureurl: json['userpictureurl']);
  }
}
