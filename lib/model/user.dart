class UserModel {
  final String id;
  final String fname;
   final String lname;
  final String email;
  final String phone;



  UserModel({
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.phone,

  });

  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'],
      fname: data['fname'],
      lname: data['lname'],
      email: data['email'],
      phone: data['phone'],
    );
  }
}