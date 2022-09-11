class UserModel {
  final String id;
  final String name;
  final String imageUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

   factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}