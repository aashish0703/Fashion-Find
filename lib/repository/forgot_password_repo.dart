import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordRepo {

  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}