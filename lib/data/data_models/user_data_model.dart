class UserDataModel {
  final String email;
  final String name;
  final String phone;
  final String uid;

  UserDataModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.uid,
  });

  factory UserDataModel.fromDoc(Map<String, dynamic> doc) => UserDataModel(
        email: doc['email'],
        name: doc['name'],
        phone: doc['phone'],
        uid: doc['uid'],
      );
}
