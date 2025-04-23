
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_find/util/util.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAccountRepo {

  final db = FirebaseFirestore.instance.collection("users");

  Future<Stream<DocumentSnapshot<Map<String, dynamic>>>> getUserDetail(String uid) async {
    final user = db
        .doc(uid)
        .snapshots();
    return user;
  }

  // Future<void> updateUser(AppUser user) async {
  //   try {
  //     print("user.uid : ${user.uid}");
  //     print("Util.uid : ${Util.uid}");
  //     db.doc(Util.uid).set(user.toMap());
  //   } catch (e) {
  //     print("[updateUser] error while updating user profile");
  //     print("[updateUser] error: $e");
  //   }
  // }
  
  Future<void> deleteUser(String uid ) async {
    final user = FirebaseAuth.instance.currentUser;
    if(user != null) {
      await user.delete();
      await FirebaseFirestore.instance.collection("users").doc(uid).delete();
      FirebaseFirestore.instance.collection("cart").where("userId", isEqualTo: uid).get().then((snapshot) {
        snapshot.docs[0].reference.delete();
        print("cart deleted with id : ${snapshot.docs[0].reference.id}");
      });
      
      print("user deleted with id : $uid");
    } else {
      print("[deleteUser] Can't delete user");
    }
  }

  Future<void> updateUser(String name, String contact, String gender, String primaryAddress) async {
    try{
      final data = {
        "name" : name,
        "contact" : contact,
        "gender" : gender,
        "primaryAddress" : primaryAddress
      };
      db.doc(Util.uid).update(data);
    } catch (e) {
      print("[updateUser] error while updating user profile");
      print("[updateUser] error: $e");
    }
  }

  Future<void> addAddress(String uid, String address) async {
    try {
      db.doc(uid).update({
        "secondaryAddresses" : FieldValue.arrayUnion([address])
      });
    } catch (e) {
      print("[addAddress] error while adding address");
      print("[addAddress] error: $e");
    }
  }

  Future<void> removePrimaryAddress(String uid) async {
    try {
      db.doc(uid).update({
        "primaryAddress" : ""
      });
      print("Address removed successfully");
    } catch (e) {
      print("[removePrimaryAddress] error while removing address");
      print("[removePrimaryAddress] error: $e");
    }
  }


  Future<void> removeAddress(String uid, String address) async {
    try {
      db.doc(uid).update({
        "secondaryAddresses" : FieldValue.arrayRemove([address])
      });
      print("Address removed successfully");
    } catch (e) {
      print("[removeAddress] error while removing address");
      print("[removeAddress] error: $e");
    }
  }
}