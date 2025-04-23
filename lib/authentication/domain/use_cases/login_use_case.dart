import 'package:fashion_find/authentication/domain/entities/login_entity.dart';
import 'package:fashion_find/authentication/domain/repositories/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginUseCase {

  final AuthenticationRepository repository;

  LoginUseCase(this.repository);

  Future<UserCredential?> call(LoginEntity loginEntity) async {
    return await repository.login(loginEntity);
  }
}