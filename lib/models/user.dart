class User {
  final String id;
  final String name;
  final String? avatarUrl;
  final bool isOnline;
  final DateTime lastSeen;

  User({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.isOnline = false,
    required this.lastSeen,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      avatarUrl: json['avatarUrl'],
      isOnline: json['isOnline'],
      lastSeen: DateTime.parse(json['lastSeen']),
    );
  }
}
