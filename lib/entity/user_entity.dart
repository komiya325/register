class UserEntity {
  const UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
    this.createdAt,
  });

  final String uid;
  final String name;
  final String email;
  final String photoUrl;
  final DateTime? createdAt;

  factory UserEntity.fromMap(Map<String, dynamic> map, String uid) {
    final createdAtRaw = map['createdAt'];
    DateTime? createdAt;

    if (createdAtRaw is DateTime) {
      createdAt = createdAtRaw;
    }

    return UserEntity(
      uid: uid,
      name: (map['name'] as String?) ?? '',
      email: (map['email'] as String?) ?? '',
      photoUrl: (map['photoUrl'] as String?) ?? '',
      createdAt: createdAt,
    );
  }
}
