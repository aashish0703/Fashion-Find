import 'package:fashion_find/authentication/domain/repositories/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleLoginUseCase {

  final AuthenticationRepository repository;
  GoogleLoginUseCase(this.repository);

  Future<UserCredential> call() async {
    final userCredentials = await repository.signInWithGoogle();
    await repository.saveDataToFireStore(userCredentials.user!);
    return userCredentials;
  }
}