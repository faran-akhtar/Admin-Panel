import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_system_dashboard/sdk/services/firebase_services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../sdk/models/student_register_model_class.dart';
import '../../../styles/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../app.dart';
import '../../../../widgets/widget_export.dart';
import '../../../../utils/utils_export.dart';

class StudentRegister extends StatelessWidget {
  StudentRegister({super.key});

  final _formKey = GlobalKey<FormState>();
  TextEditingController studentName = TextEditingController();
  TextEditingController fatherName = TextEditingController();
  TextEditingController rollNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController semester = TextEditingController();
  TextEditingController studentAddress = TextEditingController();

  String busDocumentId = '';
  double? pickupLatitude;
  double? pickupLongitude;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        backgroundColor: CustomColors.whiteColor,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Column(
                children: [
                  Theme(
                    data: ThemeData(dialogBackgroundColor: Colors.orange),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: CustomFilledButton(
                        label: 'Add New Student',
                        width: 400,
                        height: 124,
                        labelStyle: const TextStyle(color: Colors.white),
                        backgroundColor: CustomColors.skyBlueColor,
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 54),
                                  child: AlertDialog(
                                    title: const Text(
                                      'Student Register',
                                      style: TextStyle(
                                          color: CustomColors.blueColor),
                                    ), // Updated heading
                                    content: Container(
                                      color: Colors.white,
                                      width: 800,
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextInputField(
                                              label: "Student Name",
                                              controller: studentName,
                                              fillColor: Colors.transparent,
                                              validator: requiredValidator,
                                              labelTextColor: Colors.black,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            TextInputField(
                                              label: "Father Name",
                                              controller: fatherName,
                                              fillColor: Colors.transparent,
                                              validator: requiredValidator,
                                              labelTextColor: Colors.black87,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            TextInputField(
                                              label: "Roll No",
                                              controller: rollNumber,
                                              validator: requiredValidator,
                                              fillColor: Colors.transparent,
                                              labelTextColor: Colors.black87,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            TextInputField(
                                              label: "Email",
                                              controller: email,
                                              fillColor: Colors.transparent,
                                              validator: emailValidator,
                                              labelTextColor: Colors.black87,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            TextInputField(
                                              label: "Password",
                                              controller: password,
                                              fillColor: Colors.transparent,
                                              obscureText: true,
                                              validator: passwordValidator,
                                              labelTextColor: Colors.black87,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            TextInputField(
                                              label: "Phone Number",
                                              controller: phoneNumber,
                                              fillColor: Colors.transparent,
                                              textInputType:
                                                  TextInputType.number,
                                              validator: numberValidator,
                                              labelTextColor: Colors.black87,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            TextInputField(
                                              label: "Department",
                                              controller: department,
                                              fillColor: Colors.transparent,
                                              validator: requiredValidator,
                                              labelTextColor: Colors.black87,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            TextInputField(
                                              label: "Semester",
                                              controller: semester,
                                              fillColor: Colors.transparent,
                                              validator: requiredValidator,
                                              labelTextColor: Colors.black87,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            TextInputField(
                                              label: "Student Address",
                                              controller: studentAddress,
                                              validator: requiredValidator,
                                              onChanged: (query) {
                                                context
                                                    .read<
                                                        StudentRegisterCubit>()
                                                    .searchPlaces(query);
                                              },
                                              fillColor: Colors.transparent,
                                              labelTextColor: Colors.black87,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            BlocBuilder<StudentRegisterCubit,
                                                StudentRegisterState>(
                                              builder: (context, state) {
                                                return state
                                                        .suggestions!.isNotEmpty
                                                    ? SizedBox(
                                                        height: 200,
                                                        width: double.maxFinite,
                                                        child: ListView.builder(
                                                          shrinkWrap: true,
                                                          itemCount: state
                                                              .suggestions!
                                                              .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            var item = state
                                                                    .suggestions![
                                                                index];
                                                            return ListTile(
                                                              title:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  studentAddress
                                                                          .text =
                                                                      item[
                                                                          "formatted_address"];
                                                                  Map<String,
                                                                          dynamic>?
                                                                      selectedGeometry =
                                                                      item[
                                                                          'geometry'];
                                                                  if (selectedGeometry!
                                                                      .isNotEmpty) {
                                                                    pickupLatitude =
                                                                        selectedGeometry["location"]
                                                                            [
                                                                            "lat"];
                                                                    pickupLongitude =
                                                                        selectedGeometry["location"]
                                                                            [
                                                                            "lng"];
                                                                  }
                                                                },
                                                                child: Text(
                                                                  item["formatted_address"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      )
                                                    : SizedBox.fromSize();
                                              },
                                            ),
                                            StreamBuilder(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection("Buses")
                                                    .snapshots(),
                                                builder: (context,
                                                    AsyncSnapshot<
                                                            QuerySnapshot<
                                                                Map<String,
                                                                    dynamic>>>
                                                        snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const Center(
                                                      child:
                                                          CupertinoActivityIndicator(
                                                        radius: 35,
                                                        animating: true,
                                                        color: CustomColors
                                                            .whiteColor, // Color of Loader this is Primary Color Most Cases
                                                      ),
                                                    );
                                                  }
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.done) {
                                                    return const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  } else {
                                                    final List<String>
                                                        listOfBuses = snapshot
                                                            .data!.docs
                                                            .map((doc) => doc[
                                                                    'busNumber']
                                                                as String) // Convert to List of Strings
                                                            .toList();
                                                    return DropDownUpdated(
                                                        dropdownList:
                                                            listOfBuses,
                                                        dropdownValue:
                                                            const Text(
                                                                'Select Bus'),
                                                        onChanged: (p0) {
                                                          var selectedBusDocument =
                                                              snapshot
                                                                  .data!.docs
                                                                  .firstWhere(
                                                                      (element) =>
                                                                          element[
                                                                              'busNumber'] ==
                                                                          p0);
                                                          var busData =
                                                              selectedBusDocument
                                                                  .data();
                                                          busDocumentId = busData[
                                                              'busDocumentId'];
                                                        });
                                                  }
                                                }),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            if (pickupLatitude != null &&
                                                pickupLongitude != null &&
                                                busDocumentId.isNotEmpty) {
                                              FirebaseServices services =
                                                  FirebaseServices();
                                              final result = await services
                                                  .registerStudent(
                                                      studentName:
                                                          studentName.text,
                                                      fatherName:
                                                          fatherName.text,
                                                      rollNo: rollNumber.text,
                                                      email: email.text,
                                                      password: password.text,
                                                      phoneNumber:
                                                          phoneNumber.text,
                                                      department:
                                                          department.text,
                                                      busDocumentId:
                                                          busDocumentId,
                                                      semester: semester.text,
                                                      pickupAddress:
                                                          studentAddress.text,
                                                      pickupLatitude:
                                                          pickupLatitude!,
                                                      pickupLongitude:
                                                          pickupLongitude!);
                                              if (result.contains('success')) {
                                                // ignore: use_build_context_synchronously
                                                Helpers.showToast(
                                                  context: context,
                                                  title:
                                                      'Student Register Success Fully',
                                                );
                                                Navigator.of(context).pop();
                                              } else {
                                                // ignore: use_build_context_synchronously
                                                Helpers.showToast(
                                                  context: context,
                                                  title: result,
                                                );
                                              }
                                            } else {
                                              // ignore: use_build_context_synchronously
                                              Helpers.showToast(
                                                context: context,
                                                title:
                                                    'Pickup Address Invalied',
                                              );
                                            }
                                          }
                                        },
                                        child: const Text('Register'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Expanded(
                child: TabularForm(),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class TabularForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController studentName = TextEditingController();
  TextEditingController fatherName = TextEditingController();
  TextEditingController rollNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController semester = TextEditingController();
  TextEditingController studentAddress = TextEditingController();

  String busDocumentId = '';
  double? pickupLatitude;
  double? pickupLongitude;
  void _showDeleteConfirmationDialog(String docId, context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this student?'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);

                await FirebaseServices.deleteStudent(docId);
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _handleEditOperation(int rowIndex, context, student) async {
    await FirebaseServices.fetchStudentBus(student.busDocumentId);
    studentName.text = student.studentName;
    fatherName.text = student.fatherName;
    rollNumber.text = student.rollNo;
    phoneNumber.text = student.phoneNumber;
    department.text = student.department;
    semester.text = student.semester;
    studentAddress.text = student.pickupAddress.toString();
    pickupLatitude = student.pickupLatitude;
    pickupLongitude = student.pickupLongitude;
    String busDocumentId = student.busDocumentId;
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 54),
            child: AlertDialog(
              title: const Text(
                'Student Update',
                style: TextStyle(color: CustomColors.blueColor),
              ), // Updated heading
              content: Container(
                color: Colors.white,
                width: 800,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextInputField(
                        label: "Student Name",
                        controller: studentName,
                        fillColor: Colors.transparent,
                        validator: requiredValidator,
                        labelTextColor: Colors.black,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextInputField(
                        label: "Father Name",
                        controller: fatherName,
                        fillColor: Colors.transparent,
                        validator: requiredValidator,
                        labelTextColor: Colors.black87,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextInputField(
                        label: "Roll No",
                        controller: rollNumber,
                        validator: requiredValidator,
                        fillColor: Colors.transparent,
                        labelTextColor: Colors.black87,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextInputField(
                        label: "Phone Number",
                        controller: phoneNumber,
                        fillColor: Colors.transparent,
                        textInputType: TextInputType.number,
                        validator: numberValidator,
                        labelTextColor: Colors.black87,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextInputField(
                        label: "Department",
                        controller: department,
                        fillColor: Colors.transparent,
                        validator: requiredValidator,
                        labelTextColor: Colors.black87,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextInputField(
                        label: "Semester",
                        controller: semester,
                        fillColor: Colors.transparent,
                        validator: requiredValidator,
                        labelTextColor: Colors.black87,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextInputField(
                        label: "Student Address",
                        controller: studentAddress,
                        validator: requiredValidator,
                        onChanged: (query) {
                          context
                              .read<StudentRegisterCubit>()
                              .searchPlaces(query);
                        },
                        fillColor: Colors.transparent,
                        labelTextColor: Colors.black87,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      BlocBuilder<StudentRegisterCubit, StudentRegisterState>(
                        builder: (context, state) {
                          return state.suggestions!.isNotEmpty
                              ? SizedBox(
                                  height: 200,
                                  width: double.maxFinite,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state.suggestions!.length,
                                    itemBuilder: (context, index) {
                                      var item = state.suggestions![index];
                                      return ListTile(
                                        title: GestureDetector(
                                          onTap: () {
                                            studentAddress.text =
                                                item["formatted_address"];
                                            Map<String, dynamic>?
                                                selectedGeometry =
                                                item['geometry'];
                                            if (selectedGeometry!.isNotEmpty) {
                                              pickupLatitude =
                                                  selectedGeometry["location"]
                                                      ["lat"];
                                              pickupLongitude =
                                                  selectedGeometry["location"]
                                                      ["lng"];
                                            }
                                          },
                                          child: Text(
                                            item["formatted_address"]
                                                .toString(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : SizedBox.fromSize();
                        },
                      ),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("Buses")
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CupertinoActivityIndicator(
                                  radius: 35,
                                  animating: true,
                                  color: CustomColors
                                      .whiteColor, // Color of Loader this is Primary Color Most Cases
                                ),
                              );
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              final List<String> listOfBuses = snapshot
                                  .data!.docs
                                  .map((doc) => doc['busNumber']
                                      as String) // Convert to List of Strings
                                  .toList();
                              return DropDownUpdated(
                                  dropdownList: listOfBuses,
                                  dropdownValue:
                                      Text(FirebaseServices.studentBusName),
                                  onChanged: (p0) {
                                    var selectedBusDocument = snapshot
                                        .data!.docs
                                        .firstWhere((element) =>
                                            element['busNumber'] == p0);
                                    var busData = selectedBusDocument.data();
                                    busDocumentId = busData['busDocumentId'];
                                  });
                            }
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (pickupLatitude != null &&
                          pickupLongitude != null &&
                          busDocumentId.isNotEmpty) {
                        FirebaseServices services = FirebaseServices();
                        final result = await services.updateStudent(
                          studentName: studentName.text,
                          fatherName: fatherName.text,
                          rollNo: rollNumber.text,
                          stdDocid: student.studentDocumentId,
                          phoneNumber: phoneNumber.text,
                          department: department.text,
                          busDocumentId: busDocumentId,
                          semester: semester.text,
                          pickupAddress: studentAddress.text,
                          pickupLatitude: pickupLatitude!,
                          pickupLongitude: pickupLongitude!,
                        );
                        if (result.contains('success')) {
                          // ignore: use_build_context_synchronously
                          Helpers.showToast(
                            context: context,
                            title: 'Student Register Success Fully',
                          );
                          Navigator.of(context).pop();
                        } else {
                          // ignore: use_build_context_synchronously
                          Helpers.showToast(
                            context: context,
                            title: result,
                          );
                        }
                      } else {
                        // ignore: use_build_context_synchronously
                        Helpers.showToast(
                          context: context,
                          title: 'Pickup Address Invalied',
                        );
                      }
                    }
                  },
                  child: const Text('Update'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showLatLngDialog(double latitude, double longitude, context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Latitude and Longitude'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Latitude: $latitude'),
              Text('Longitude: $longitude'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Open map website
                launch('https://maps.google.com/?q=$latitude,$longitude');
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Show on Map'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<StudentRegisterModelClass>>(
      stream: FirebaseServices.fetchStudentData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                color: CustomColors.whiteColorShade, // Replace with your color
                child: DataTable(
                  border: TableBorder.all(color: CustomColors.offWhiteColor),
                  columnSpacing: 12,
                  dividerThickness: 1,
                  columns: const [
                    DataColumn(
                        label: Text('Student Name'), tooltip: 'Student Name'),
                    DataColumn(
                        label: Text('Father Name'), tooltip: 'Father Name'),
                    DataColumn(label: Text('Roll No'), tooltip: 'Roll No'),
                    DataColumn(
                        label: Text('Student Email'), tooltip: 'Student Email'),
                    DataColumn(
                        label: Text('Phone Number'), tooltip: 'Phone Number'),
                    DataColumn(
                        label: Text('Department'), tooltip: 'Department'),
                    DataColumn(label: Text('Semester'), tooltip: 'Semester'),
                    DataColumn(
                        label: Text('Student Address'),
                        tooltip: 'Student Address'),
                    DataColumn(
                        label: Text('Lat/Lng'), tooltip: 'Student Lat/Lng'),
                    DataColumn(
                        label: Text('Bus Document Id'),
                        tooltip: 'Bus Document Id'),
                    DataColumn(
                        label: Text('Operations'), tooltip: 'Operations'),
                  ],
                  rows: List<DataRow>.generate(snapshot.data!.length, (index) {
                    final student = snapshot.data![index];
                    return DataRow(
                      cells: [
                        DataCell(Text(student.studentName)),
                        DataCell(Text(student.fatherName)),
                        DataCell(Text(student.rollNo)),
                        DataCell(Text(student.email)),
                        DataCell(Text(student.phoneNumber)),
                        DataCell(Text(student.department)),
                        DataCell(Text(student.semester)),
                        DataCell(SizedBox(
                          width: 300,
                          child: Text(
                            student.pickupAddress,
                            maxLines: 5,
                          ),
                        )),
                        DataCell(ElevatedButton(
                            onPressed: () {
                              _showLatLngDialog(student.pickupLatitude,
                                  student.pickupLongitude, context);
                            },
                            child: const Text('Location'))),
                        DataCell(FutureBuilder<DocumentSnapshot>(
          
          future: FirebaseFirestore.instance.collection('Buses').doc(student.busDocumentId).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Text('No data available.');
            }

            // Accessing the document's 'busNumber' field
            String busNumber = snapshot.data!.get('busNumber');

            return Text(busNumber); // Display bus number
          },
        ),),
      
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.green),
                                onPressed: () {
                                  _handleEditOperation(index, context,
                                      student); // Handle edit operation
                                },
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _showDeleteConfirmationDialog(
                                      student.studentDocumentId,
                                      context); // Show delete confirmation dialog
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
