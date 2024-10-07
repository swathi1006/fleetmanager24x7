class Attendance {
  final String userId;
  final DateTime checkInTime;
  final DateTime? checkOutTime;

  Attendance({
    required this.userId,
    required this.checkInTime,
    this.checkOutTime,
  });

  // Convert a Dart object to a JSON-like map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'checkInTime': checkInTime.toIso8601String(),
      'checkOutTime': checkOutTime?.toIso8601String(),
    };
  }

  // Convert JSON-like map to a Dart object
  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      userId: map['userId'] as String,
      checkInTime: DateTime.parse(map['checkInTime'] as String),
      checkOutTime: map['checkOutTime'] != null ? DateTime.parse(map['checkOutTime']) : null,
    );
  }
}
