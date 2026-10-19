import 'package:cloud_firestore/cloud_firestore.dart';

enum AppRole {
  user,
  verifier,
  admin;

  String get label => switch (this) {
    AppRole.user => 'User',
    AppRole.verifier => 'Verifier',
    AppRole.admin => 'Admin',
  };

  static AppRole fromString(Object? value) => switch (value) {
    'verifier' => AppRole.verifier,
    'admin' => AppRole.admin,
    _ => AppRole.user,
  };
}

class AppUser {
  const AppUser({
    required this.userId,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
    this.avatar = '🙂',
    this.level = 1,
    this.totalXP = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lastStreakDate,
    this.inviteCode = '',
    this.verifierIds = const [],
    this.isDisabled = false,
  });

  final String userId;
  final String name;
  final String email;
  final AppRole role;
  final DateTime createdAt;
  final String avatar;
  final int level;
  final int totalXP;
  final int currentStreak;
  final int longestStreak;
  final String? lastStreakDate;
  final String inviteCode;
  final List<String> verifierIds;
  final bool isDisabled;

  factory AppUser.fromMap(Map<String, dynamic> map) {
    final createdAtValue = map['createdAt'];
    final createdAt = switch (createdAtValue) {
      Timestamp timestamp => timestamp.toDate(),
      DateTime dateTime => dateTime,
      _ => DateTime.now(),
    };

    return AppUser(
      userId: map['userId'] as String? ?? '',
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      role: AppRole.fromString(map['role']),
      createdAt: createdAt,
      avatar: map['avatar'] as String? ?? '🙂',
      level: (map['level'] as num?)?.toInt() ?? 1,
      totalXP: (map['totalXP'] as num?)?.toInt() ?? 0,
      currentStreak: (map['currentStreak'] as num?)?.toInt() ?? 0,
      longestStreak: (map['longestStreak'] as num?)?.toInt() ?? 0,
      lastStreakDate: map['lastStreakDate'] as String?,
      inviteCode: map['inviteCode'] as String? ?? '',
      verifierIds: List<String>.from(map['verifierIds'] as List? ?? const []),
      isDisabled: map['isDisabled'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() => {
    'userId': userId,
    'name': name,
    'email': email,
    'role': role.name,
    'createdAt': Timestamp.fromDate(createdAt),
    'avatar': avatar,
    'level': level,
    'totalXP': totalXP,
    'currentStreak': currentStreak,
    'longestStreak': longestStreak,
    'lastStreakDate': lastStreakDate,
    'inviteCode': inviteCode,
    'verifierIds': verifierIds,
    'isDisabled': isDisabled,
  };
}