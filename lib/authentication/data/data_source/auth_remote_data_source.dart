import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_find/authentication/data/model/login_model.dart';
import 'package:fashion_find/authentication/data/model/register_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../model/user_model.dart';
import '../../../util/util.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredential?> login(LoginModel loginModel);
  Future<UserCredential> signInWithGoogle();
  Future<void> saveDataToFireStore(User user);
  Future<UserCredential?> register(RegisterModel registerModel);
}

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {

  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserCredential?> login(LoginModel loginModel) async {
    if(loginModel.email.isNotEmpty && loginModel.password.isNotEmpty) {
      try {
        final credentials = await _firebaseAuth.signInWithEmailAndPassword(email: loginModel.email, password: loginModel.password);
        print("[login] Credentials of logged user : $credentials");

        User? user = credentials.user;
        if(user != null) {
          Util.uid = user.uid;
          print("[login] Util.uid: ${Util.uid}");
        }

        return credentials;
      } catch (e) {
        print("[login] Error in Login");
        throw Exception(e.toString());
      }
    }
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        throw "Sign In cancelled";
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      print("[signInWithGoogle] credentials: $credential");

      final userCredentials =
      await FirebaseAuth.instance.signInWithCredential(credential);
      print("[signInWithGoogle] userCredentials: $userCredentials");

      final user = userCredentials.user;
      if (user != null) {
        Util.uid = user.uid;
        await saveDataToFireStore(user);
      } else {
        print("[signInWithGoogle] User is null");
      }

      return userCredentials;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> saveDataToFireStore(User user) async {
    final docRef = FirebaseFirestore.instance.collection("users").doc(user.uid);
    final docSnapshot = await docRef.get();
    if(!docSnapshot.exists) {
      AppUser appUser = AppUser(
        uid: user.uid,
        name: user.displayName ?? "",
        email: user.email ?? "",
        contact: "",
        gender: "",
        primaryAddress: "",
        secondaryAddresses: [],
      );
      Map<String, dynamic> userData = appUser.toMap();
      await docRef.set(userData);
    }
  }

  @override
  Future<UserCredential?> register(RegisterModel registerModel) async {
    if(registerModel.name.isNotEmpty && registerModel.email.isNotEmpty && registerModel.contact.isNotEmpty) {
      try {
        final credentials = await _firebaseAuth.createUserWithEmailAndPassword(email: registerModel.email, password: registerModel.password);
        print("[register] credentials: $credentials");

        print("credentials.user.uid: ${credentials.user!.uid}");
        Util.uid = credentials.user!.uid;

        AppUser user = AppUser(
            uid: credentials.user!.uid,
            name: registerModel.name,
            email: registerModel.email,
            contact: registerModel.contact,
            gender: "",
            primaryAddress: "",
            secondaryAddresses: []
        );

        Map<String, dynamic> userData = user.toMap();

        FirebaseFirestore.instance
            .collection("users")
            .doc(credentials.user!.uid)
            .set(userData);

        return credentials;
      } catch(e) {
        print("Error while registering");
        throw Exception(e.toString());
      }
    }
  }
}