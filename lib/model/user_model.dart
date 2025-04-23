

class AppUser {
  String? uid;
  String name;
  String? email;
  String contact;
  String gender;
  String primaryAddress;
  List<String>? secondaryAddresses;

  AppUser({
    this.uid,
    required this.name,
    this.email,
    required this.contact,
    required this.gender,
    required this.primaryAddress,
    this.secondaryAddresses,
  });

  factory AppUser.fromJson(Map<String, dynamic> data) {
    // var addressFromJson = data["secondaryAddresses"];
    // List<String> secondaryAddressesList = addressFromJson.cast<String>();
    return AppUser(
        uid: data["uid"] ?? "",
        name: data["name"],
        email: data["email"] ?? "",
        contact: data["contact"],
        gender: data["gender"],
        primaryAddress: data["primaryAddress"],
        // secondaryAddresses: secondaryAddressesList
      secondaryAddresses: data["secondaryAddresses"].cast<String>(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name" : name,
      "email" : email,
      "contact" : contact,
      "gender" : gender,
      "primaryAddress" : primaryAddress,
      "secondaryAddresses" : secondaryAddresses,
    };
  }
}