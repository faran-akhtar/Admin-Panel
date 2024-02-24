import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tracking_system_dashboard/sdk/models/atd_model.dart';
import 'package:tracking_system_dashboard/sdk/models/student_register_model_class.dart';
import '../sdk.dart';

class FirebaseServices {
  static String studentBusName = '';
  static String driverBusName = '';
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> registerBus({
    required String busNumber,
    required String morningTimeStartFrom,
    required String morningTimeDropOff,
    required String eveningTimeStartFrom,
    required String eveningTimeDropOff,
  }) async {
    String res = "Some error Occured";

    try {
      DocumentReference documentReference =
          firebaseFirestore.collection('Buses').doc();

      BusRegisterModelClass busRegisterModelClass = BusRegisterModelClass(
          busNumber: busNumber,
          morningTimeStartFrom: morningTimeStartFrom,
          morningTimeDropOff: morningTimeDropOff,
          eveningTimeStartFrom: eveningTimeStartFrom,
          eveningTimeDropOff: eveningTimeDropOff,
          busDocumentId: documentReference.id,
          latitude: 0.0,
          longitude: 0.0);
      await documentReference.set(busRegisterModelClass.toJson());
      res = 'success';
    } on FirebaseException {
      res = 'Some Error Occred While Uploading data';
    }
    return res;
  }

  // Driver Register
  Future<String> registerDriver({
    required String driverName,
    required String driverEmail,
    required String driverPhoneNumber,
    required String driverLicenseNumber,
    required String driverAddress,
    required String driverPassword,
    required String busDocumentId,
  }) async {
    String res = "Some error Occured";

    try {
      DocumentReference documentReference =
          firebaseFirestore.collection('DriverData').doc();

      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: driverEmail,
        password: driverPassword,
      );
      final String userId = userCredential.user!.uid;
      DriverRegisterModelClass driverRegisterModelClass =
          DriverRegisterModelClass(
        driverName: driverName,
        driverEmail: driverEmail,
        driverPhoneNumber: driverPhoneNumber,
        driverAddress: driverAddress,
        driverLicenseNumber: driverLicenseNumber,
        busDocumentId: busDocumentId,
        driverDocumentId: documentReference.id,
        driverUserId: userId,
      );

      await documentReference.set(driverRegisterModelClass.toJson());
      res = 'success';
    } on FirebaseException {
      res = 'Some Error Occred While Uploading data';
    }
    return res;
  }

  // Student Register
  Future<String> registerStudent({
    required String studentName,
    required String fatherName,
    required String rollNo,
    required String email,
    required String password,
    required String phoneNumber,
    required String department,
    required String busDocumentId,
    required String semester,
    required String pickupAddress,
    required double pickupLatitude,
    required double pickupLongitude,
  }) async {
    String res = "Some error Occured";

    try {
      DocumentReference documentReference =
          firebaseFirestore.collection('StudentData').doc();

      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final String userId = userCredential.user!.uid;
      StudentRegisterModelClass studentRegisterModelClass =
          StudentRegisterModelClass(
        studentName: studentName,
        fatherName: fatherName,
        rollNo: rollNo,
        email: email,
        phoneNumber: phoneNumber,
        department: department,
        semester: semester,
        pickupAddress: pickupAddress,
        pickupLatitude: pickupLatitude,
        pickupLongitude: pickupLongitude,
        busDocumentId: busDocumentId,
        studentDocumentId: documentReference.id,
        studentUserId: userId,
      );

      await documentReference.set(studentRegisterModelClass.toJson());
      res = 'success';
    } on FirebaseException {
      res = 'Some Error Occred While Uploading data';
    }
    return res;
  }

  // Student Update
  Future<String> updateStudent({
    required String studentName,
    required String fatherName,
    required String rollNo,
    required String stdDocid,
    required String phoneNumber,
    required String department,
    required String busDocumentId,
    required String semester,
    required String pickupAddress,
    required double pickupLatitude,
    required double pickupLongitude,
  }) async {
    String res = "Some error Occured";

    try {
      DocumentReference documentReference =
          firebaseFirestore.collection('StudentData').doc(stdDocid);

      await documentReference.update({
        'studentName': studentName,
        'fatherName': fatherName,
        'rollNo': rollNo,
        'phoneNumber': phoneNumber,
        'department': department,
        'semester': semester,
        'pickupAddress': pickupAddress,
        'pickupLatitude': pickupLatitude,
        'pickupLongitude': pickupLongitude,
        'busDocumentId': busDocumentId,
      });
      res = 'success';
    } on FirebaseException {
      res = 'Some Error Occred While Uploading data';
    }
    return res;
  }

  // Student Update
  Future<String> updateDriver({
    required String driverDocid,
    required String driverName,
    required String driverPhoneNumber,
    required String busDocumentId,
    required String driverLicense,
    required String driverAddress,
  }) async {
    String res = "Some error Occured";

    try {
      DocumentReference documentReference =
          firebaseFirestore.collection('DriverData').doc(driverDocid);

      await documentReference.update({
        'driverPhoneNumber': driverPhoneNumber,
        'driverName': driverName,
        'driverLicenseNumber': driverLicense,
        'driverAddress': driverAddress,
        'busDocumentId': busDocumentId,
      });
      res = 'success';
    } on FirebaseException {
      res = 'Some Error Occred While Uploading data';
    }
    return res;
  }

  // Student Update
  Future<String> updateBus({
    required String busDocId,
    required String busNumber,
    required String morningTimeStartFrom,
    required String morningTimeDropOff,
    required String eveningTimeStartFrom,
    required String eveningTimeDropOff,
  }) async {
    String res = "Some error Occured";

    try {
      DocumentReference documentReference =
          firebaseFirestore.collection('Buses').doc(busDocId);

      await documentReference.update({
        'busNumber': busNumber,
        'morningTimeStartFrom': morningTimeStartFrom,
        'morningTimeDropOff': morningTimeDropOff,
        'eveningTimeStartFrom': eveningTimeStartFrom,
        'eveningTimeDropOff': eveningTimeDropOff,
      });
      res = 'success';
    } on FirebaseException {
      res = 'Some Error Occred While Uploading data';
    }
    return res;
  }

  static Stream<List<StudentRegisterModelClass>> fetchStudentData() {
    return FirebaseFirestore.instance
        .collection('StudentData')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return StudentRegisterModelClass.fromMap(doc.data());
      }).toList();
    });
  }

  static fetchStudentBus(String doc) async {
    var busDocumentSnapshot =
        await FirebaseFirestore.instance.collection('Buses').doc(doc).get();

    if (busDocumentSnapshot.exists) {
      var busData = busDocumentSnapshot.data();
      studentBusName = busData!['busNumber'];
    } else {
      studentBusName = '';
    }
  }

  static fetchDriverBus(String doc) async {
    var busDocumentSnapshot =
        await FirebaseFirestore.instance.collection('Buses').doc(doc).get();

    if (busDocumentSnapshot.exists) {
      var busData = busDocumentSnapshot.data();
      driverBusName = busData!['busNumber'];
    } else {
      driverBusName = '';
    }
  }

  static Future<void> deleteStudent(String docId) async {
    try {
      // Delete the student document from Firestore
      await FirebaseFirestore.instance
          .collection('StudentData')
          .doc(docId)
          .delete();
    } catch (error) {
      // Handle error
      print('Error deleting student: $error');
    }
  }

  static Future<void> deleteDriver(String docId) async {
    try {
      // Delete the student document from Firestore
      await FirebaseFirestore.instance
          .collection('DriverData')
          .doc(docId)
          .delete();
    } catch (error) {
      // Handle error
      print('Error deleting student: $error');
    }
  }

  static Future<void> deleteBus(String docId) async {
    try {
      // Delete the student document from Firestore
      await FirebaseFirestore.instance.collection('Buses').doc(docId).delete();
    } catch (error) {
      // Handle error
      print('Error deleting student: $error');
    }
  }

  static Stream<List<DriverRegisterModelClass>> fetchDriverData() {
    return FirebaseFirestore.instance
        .collection('DriverData')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return DriverRegisterModelClass.fromMap(doc.data());
      }).toList();
    });
  }

  static Stream<List<BusRegisterModelClass>> fetchBuses() {
    return FirebaseFirestore.instance
        .collection('Buses')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return BusRegisterModelClass.fromMap(doc.data());
      }).toList();
    });
  }
}
