class Token extends Object {
  String token;
  String privatetoken;

  Token({required this.token, required this.privatetoken});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(token: json['token'], privatetoken: json['privatetoken']);
  }
}
