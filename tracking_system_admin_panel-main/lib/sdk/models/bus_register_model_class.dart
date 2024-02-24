class BusRegisterModelClass {
  final String busNumber;
  final String morningTimeStartFrom;
  final String morningTimeDropOff;
  final String eveningTimeStartFrom;
  final String eveningTimeDropOff;
  double? latitude;
  double? longitude;
  final String busDocumentId;
  BusRegisterModelClass({
    required this.busNumber,
    required this.morningTimeStartFrom,
    required this.morningTimeDropOff,
    required this.eveningTimeStartFrom,
    required this.eveningTimeDropOff,
    this.latitude,
    this.longitude,
    required this.busDocumentId,
  });

  BusRegisterModelClass copyWith({
    String? busNumber,
    String? morningTimeStartFrom,
    String? morningTimeDropOff,
    String? eveningTimeStartFrom,
    String? eveningTimeDropOff,
    double? latitude,
    double? longitude,
    String? busDocumentId,
  }) {
    return BusRegisterModelClass(
      busNumber: busNumber ?? this.busNumber,
      morningTimeStartFrom: morningTimeStartFrom ?? this.morningTimeStartFrom,
      morningTimeDropOff: morningTimeDropOff ?? this.morningTimeDropOff,
      eveningTimeStartFrom: eveningTimeStartFrom ?? this.eveningTimeStartFrom,
      eveningTimeDropOff: eveningTimeDropOff ?? this.eveningTimeDropOff,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      busDocumentId: busDocumentId ?? this.busDocumentId,
    );
  }

  Map<String, dynamic> toJson() => {
        'busNumber': busNumber,
        'morningTimeStartFrom': morningTimeStartFrom,
        'morningTimeDropOff': morningTimeDropOff,
        'eveningTimeStartFrom': eveningTimeStartFrom,
        'eveningTimeDropOff': eveningTimeDropOff,
        'latitude': latitude,
        'longitude': longitude,
        'busDocumentId': busDocumentId,
      };

  factory BusRegisterModelClass.fromMap(Map<String, dynamic> map) {
    return BusRegisterModelClass(
      busNumber: map['busNumber'] as String,
      morningTimeStartFrom: map['morningTimeStartFrom'] as String,
      morningTimeDropOff: map['morningTimeDropOff'] as String,
      eveningTimeStartFrom: map['eveningTimeStartFrom'] as String,
      eveningTimeDropOff: map['eveningTimeDropOff'] as String,
      latitude: map['latitude'] != null ? map['latitude'] as double : null,
      longitude: map['longitude'] != null ? map['longitude'] as double : null,
      busDocumentId: map['busDocumentId'] as String,
    );
  }
}
