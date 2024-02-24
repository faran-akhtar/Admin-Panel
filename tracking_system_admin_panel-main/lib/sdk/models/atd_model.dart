import 'package:cloud_firestore/cloud_firestore.dart';

class AtdModel {
  final String? checkInLocation;
  final Timestamp? checkInTime;
  final String? checkOutLocation;
  final Timestamp? checkOutTime;
  final String? studentUserId;

  AtdModel({
    required this.checkInLocation,
    required this.checkInTime,
    required this.checkOutLocation,
    required this.checkOutTime,
    required this.studentUserId,
  });

  factory AtdModel.fromMap(Map<String, dynamic> map) {
    return AtdModel(
      checkInLocation: map['checkInLocation'] as String,
      checkInTime: map['checkInTime'] as Timestamp,
      checkOutLocation: map['checkOutLocation'] as String,
      checkOutTime: map['checkOutTime'] as Timestamp,
      studentUserId: map['studentUserId'] as String,
    );
  }

  DateTime get checkInDateTime => checkInTime!.toDate();
  DateTime get checkOutDateTime => checkOutTime!.toDate();
}

class AttendanceData {
  final String studentUserId;
  final List<AtdModel> attendanceList;

  AttendanceData({
    required this.studentUserId,
    required this.attendanceList,
  });

  factory AttendanceData.fromMap(Map<String, dynamic> map) {
    List<dynamic> rawAttendanceList = map['attendanceList'];
    List<AtdModel> attendanceList = rawAttendanceList.map((rawData) {
      return AtdModel.fromMap(rawData);
    }).toList();

    return AttendanceData(
      studentUserId: map['studentUserId'] as String,
      attendanceList: attendanceList,
    );
  }
}
