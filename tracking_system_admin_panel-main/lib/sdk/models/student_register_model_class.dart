class StudentRegisterModelClass {
  final String studentName;
  final String fatherName;
  final String rollNo;
  final String email;
  final String phoneNumber;
  final String department;
  final String semester;
  final String pickupAddress;
  final double pickupLatitude;
  final double pickupLongitude;
  final String busDocumentId;
  final String studentDocumentId;
  final String studentUserId;

  StudentRegisterModelClass({
    required this.studentName,
    required this.fatherName,
    required this.rollNo,
    required this.email,
    required this.phoneNumber,
    required this.department,
    required this.semester,
    required this.pickupAddress,
    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.busDocumentId,
    required this.studentDocumentId,
    required this.studentUserId,
  });

  Map<String, dynamic> toJson() => {
        'studentName': studentName,
        'fatherName': fatherName,
        'rollNo': rollNo,
        'email': email,
        'phoneNumber': phoneNumber,
        'department': department,
        'semester': semester,
        'pickupAddress': pickupAddress,
        'pickupLatitude': pickupLatitude,
        'pickupLongitude': pickupLongitude,
        'busDocumentId': busDocumentId,
        'studentDocumentId': studentDocumentId,
        'studentUserId': studentUserId,
      };

  factory StudentRegisterModelClass.fromMap(Map<String, dynamic> map) {
    return StudentRegisterModelClass(
      studentName: map['studentName'] as String,
      fatherName: map['fatherName'] as String,
      rollNo: map['rollNo'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      department: map['department'] as String,
      semester: map['semester'] as String,
      pickupAddress: map['pickupAddress'] as String,
      pickupLatitude: map['pickupLatitude'] as double,
      pickupLongitude: map['pickupLongitude'] as double,
      busDocumentId: map['busDocumentId'] as String,
      studentDocumentId: map['studentDocumentId'] as String,
      studentUserId: map['studentUserId'] as String,
    );
  }
}
