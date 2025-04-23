import 'package:fashion_find/authentication/domain/entities/login_entity.dart';
import 'package:fashion_find/authentication/domain/entities/register_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';


abstract class AuthenticationRepository {

  Future<UserCredential?> login(LoginEntity loginEntity);
  Future<UserCredential> signInWithGoogle();
  Future<void> saveDataToFireStore(User user);
  Future<void> register(RegisterEntity registerEntity);
}