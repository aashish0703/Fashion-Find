import 'package:fashion_find/authentication/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  // LoginModel({required super.email, required super.password});
  LoginModel({required String email, required String password}) : super(email: email, password: password);

}