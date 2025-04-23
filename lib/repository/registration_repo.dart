import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_find/model/user_model.dart';
import 'package:fashion_find/repository/shopping_cart_repo.dart';
import 'package:fashion_find/util/util.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationRepo {
  final _fireBaseAuth = FirebaseAuth.instance;

  ShoppingCartRepo shoppingCartRepo = ShoppingCartRepo();

  Future<void> register(String name, String email, String password, String contact, String primaryAddress) async {
    if(name.isNotEmpty && email.isNotEmpty && contact.isNotEmpty && primaryAddress.isNotEmpty) {
      try {
        final credentials = await _fireBaseAuth.createUserWithEmailAndPassword(email: email, password: password);
        print("[register] credentials: $credentials");

        print("credentials.user.uid: ${credentials.user!.uid}");
        Util.uid = credentials.user!.uid;

        AppUser user = AppUser(
            uid: credentials.user!.uid,
            name: name,
            email: email,
            contact: contact,
            gender: "",
            primaryAddress: primaryAddress,
            secondaryAddresses: [],
        );

        Map<String, dynamic> userData = user.toMap();

        FirebaseFirestore.instance
            .collection("users")
            .doc(credentials.user!.uid)
            .set(userData);

      } catch(e) {
        print("Error while registering");
        throw Exception(e.toString());
      }
    }
  }
}