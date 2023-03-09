class User {
  String? name;
  String? email;
  String? password;
  String? token;
  String? photo;

  User({this.name, this.email, this.token, this.password});

  User.fromMap(Map<String, dynamic> map) {
    name = map['user']['name'];
    email = map['user']['email'];
    token = map['token']['access'];
    password = map['user']['password'];
  }

  Map<String, dynamic> toMapServidor() {
    return {
      'email': email,
      'password': password,
    };
  }

  Map<String, dynamic> toRegisterUserServer() {
    return {
      'name': name,
      'username': name,
      'email': email,
      'password': password
    };
  }
}
