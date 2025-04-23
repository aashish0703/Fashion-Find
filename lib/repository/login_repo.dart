import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_find/repository/shopping_cart_repo.dart';
import 'package:fashion_find/util/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/user_model.dart';

class LoginRepo {

  final firebaseAuth = FirebaseAuth.instance;

  ShoppingCartRepo shoppingCartRepo = ShoppingCartRepo();

  Future<User?> login(String email, String password) async {
    User? emptyUser;
    if(email.isNotEmpty && password.isNotEmpty) {
      try {
        final credentials = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
        print("[authentication] Credentials of logged user : $credentials");

        User? user = credentials.user;
        if(user != null) {
          Util.uid = user.uid;
          print("[authentication] Util.uid: ${Util.uid}");
        }

        final appUser = await FirebaseFirestore.instance.collection("users").doc(Util.uid).get();
        if(appUser.exists) {
          String cartId = appUser["cartId"] ?? "" ;
          print("[login] appUser cartId: ${appUser["cartId"]}");
          Util.cartId = cartId;
          print("[login] Util.cartId: ${Util.cartId}");
        }

        print("[login] Util.cartId: ${Util.cartId}");
        return user;
      } catch (e) {
        print("[authentication] Error in Login");
        throw Exception(e.toString());
      }

    }
    return emptyUser;
  }

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
}