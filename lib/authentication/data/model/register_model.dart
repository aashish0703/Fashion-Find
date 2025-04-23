import 'package:fashion_find/authentication/domain/entities/register_entity.dart';

class RegisterModel extends RegisterEntity {
  RegisterModel({
    required String name,
    required String email,
    required String password,
    required String contact,
  }) : super(name: name, email: email, password: password, contact: contact);

  factory RegisterModel.formJson(Map<String, dynamic> json) {
    return RegisterModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        contact: json["contact"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name" : name,
      "email": email,
      "password" : password,
      "contact" : contact
    };
  }
}