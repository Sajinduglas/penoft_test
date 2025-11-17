class User {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? picture;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.picture,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'picture': picture,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString(),
      name: (json['name'] ?? json['fullname'])?.toString(),
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
      picture: json['picture']?.toString(),
    );
  }
}
