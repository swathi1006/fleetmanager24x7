// class Attendance {
//   final String userId;
//   final DateTime checkInTime;
//   final DateTime? checkOutTime;

//   Attendance({
//     required this.userId,
//     required this.checkInTime,
//     this.checkOutTime,
//   });

//   // Convert a Dart object to a JSON-like map
//   Map<String, dynamic> toMap() {
//     return {
//       'userId': userId,
//       'checkInTime': checkInTime.toIso8601String(),
//       'checkOutTime': checkOutTime?.toIso8601String(),
//     };
//   }

//   // Convert JSON-like map to a Dart object
//   factory Attendance.fromMap(Map<String, dynamic> map) {
//     return Attendance(
//       userId: map['userId'] as String,
//       checkInTime: DateTime.parse(map['checkInTime'] as String),
//       checkOutTime: map['checkOutTime'] != null ? DateTime.parse(map['checkOutTime']) : null,
//     );
//   }
// }

class Attendance {
  final String userId;
  final String driverId;     // Added driver ID
  final String driverUsername;  // Added driver username
  final List<AttendanceRecord> attendanceRecords;  // To store multiple attendance records

  Attendance({
    required this.userId,
    required this.driverId,
    required this.driverUsername,
    required this.attendanceRecords,
  });

  // Convert a Dart object to a JSON-like map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'driverId': driverId,
      'driverUsername': driverUsername,
      'attendanceRecords': attendanceRecords.map((record) => record.toMap()).toList(),
    };
  }

  // Convert JSON-like map to a Dart object
  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      userId: map['userId'] as String,
      driverId: map['driverId'] as String,
      driverUsername: map['driverUsername'] as String,
      attendanceRecords: List<AttendanceRecord>.from(
        map['attendanceRecords'].map((record) => AttendanceRecord.fromMap(record)),
      ),
    );
  }
}

// New class to store individual attendance records
class AttendanceRecord {
  final DateTime checkInTime;
  final DateTime? checkOutTime;

  AttendanceRecord({
    required this.checkInTime,
    this.checkOutTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'checkInTime': checkInTime.toIso8601String(),
      'checkOutTime': checkOutTime?.toIso8601String(),
    };
  }

  factory AttendanceRecord.fromMap(Map<String, dynamic> map) {
    return AttendanceRecord(
      checkInTime: DateTime.parse(map['checkInTime']),
      checkOutTime: map['checkOutTime'] != null ? DateTime.parse(map['checkOutTime']) : null,
    );
  }
}

