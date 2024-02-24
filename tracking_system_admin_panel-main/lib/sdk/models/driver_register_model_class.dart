class DriverRegisterModelClass {
  final String driverName;
  final String driverEmail;
  final String driverPhoneNumber;
  final String driverLicenseNumber;
  final String driverAddress;
  final String busDocumentId;
  final String driverDocumentId;
  final String driverUserId;

  DriverRegisterModelClass({
    required this.driverName,
    required this.driverEmail,
    required this.driverPhoneNumber,
    required this.driverLicenseNumber,
    required this.driverAddress,
    required this.busDocumentId,
    required this.driverDocumentId,
    required this.driverUserId,
  });

  Map<String, dynamic> toJson() => {
        'driverName': driverName,
        'driverEmail': driverEmail,
        'driverPhoneNumber': driverPhoneNumber,
        'driverLicenseNumber': driverLicenseNumber,
        'driverAddress': driverAddress,
        'busDocumentId': busDocumentId,
        'driverDocumentId': driverDocumentId,
        'driverUserId': driverUserId,
      };

  factory DriverRegisterModelClass.fromMap(Map<String, dynamic> map) {
    return DriverRegisterModelClass(
      driverName: map['driverName'] as String,
      driverEmail: map['driverEmail'] as String,
      driverPhoneNumber: map['driverPhoneNumber'] as String,
      driverLicenseNumber: map['driverLicenseNumber'] as String,
      driverAddress: map['driverAddress'] as String,
      busDocumentId: map['busDocumentId'] as String,
      driverDocumentId: map['driverDocumentId'] as String,
      driverUserId: map['driverUserId'] as String,
    );
  }
}
