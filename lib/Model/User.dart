import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.listUser,
  });

  List<ListUser> listUser;

  factory User.fromJson(Map<String, dynamic> json) => User(
    listUser: List<ListUser>.from(json["listUser"].map((x) => ListUser.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listUser": List<dynamic>.from(listUser.map((x) => x.toJson())),
  };
}

class ListUser {
  ListUser({
    this.id,
    this.nama,
    this.email,
    this.password,
    this.alamat,
  });

  String id;
  String nama;
  String email;
  String password;
  String alamat;

  factory ListUser.fromJson(Map<String, dynamic> json) => ListUser(
    id: json["id"],
    nama: json["nama"],
    email: json["email"],
    password: json["password"],
    alamat: json["alamat"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama": nama,
    "email": email,
    "password": password,
    "alamat": alamat,
  };
}
