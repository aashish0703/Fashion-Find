  class RegisterEntity {

  final String? uid;
  final String name;
  final String email;
  final String password;
  final String contact;
  final String? address;

  RegisterEntity({this.uid, required this.name, required this.email, required this.password, required this.contact, this.address});
}