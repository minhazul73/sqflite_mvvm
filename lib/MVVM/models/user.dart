import 'package:get/get.dart';

class User {
  int? id;
  RxString name;
  RxInt age;

  User({this.id, required String name, required int age})
      : name = name.obs,
        age = age.obs;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name.value,
      'age': age.value,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      age: map['age'],
    );
  }
}
