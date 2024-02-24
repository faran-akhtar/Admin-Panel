import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_system_dashboard/sdk/models/driver_register_model_class.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../sdk/models/student_register_model_class.dart';
import '../../../../sdk/services/firebase_services.dart';
import '../../../../styles/colors/colors.dart';
import '../../../../utils/helpers.dart';
import '../../../../utils/validations_handler.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../app.dart';

class TabularFormDriver extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController driverName = TextEditingController();
  TextEditingController driverEmail = TextEditingController();
  TextEditingController driverPhoneNumber = TextEditingController();
  TextEditingController driverLicense = TextEditingController();
  TextEditingController driverAddress = TextEditingController();
  TextEditingController driverPassword = TextEditingController();

  String busDocumentId = '';
  void _showDeleteConfirmationDialog(String docId, context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this driver?'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);

                await FirebaseServices.deleteDriver(docId);
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

  void _handleEditOperation(int rowIndex, context, driver) async {
    await FirebaseServices.fetchDriverBus(driver.busDocumentId);
    driverName.text = driver.driverName;
    driverPhoneNumber.text = driver.driverPhoneNumber;
    driverLicense.text = driver.driverLicenseNumber;
    driverAddress.text = driver.driverAddress;

    String busDocumentId = driver.busDocumentId;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 54),
            child: AlertDialog(
              title: const Text('Driver Update'), // Updated heading
              content: Container(
                color: Colors.white,
                width: 800,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextInputField(
                        label: "Driver Name",
                        controller: driverName,
                        fillColor: Colors.transparent,
                        labelTextColor: Colors.black87,
                        validator: requiredValidator,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextInputField(
                        label: "Driver Phone Number",
                        controller: driverPhoneNumber,
                        fillColor: Colors.transparent,
                        textInputType: TextInputType.number,
                        labelTextColor: Colors.black87,
                        validator: numberValidator,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextInputField(
                        label: "Driver License Number",
                        controller: driverLicense,
                        fillColor: Colors.transparent,
                        labelTextColor: Colors.black87,
                        validator: requiredValidator,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextInputField(
                        label: "Driver Address",
                        controller: driverAddress,
                        fillColor: Colors.transparent,
                        labelTextColor: Colors.black87,
                        validator: requiredValidator,
                      ),
                      const SizedBox(
                        height: 5,
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
                                      Text(FirebaseServices.driverBusName),
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
                    if (_formKey.currentState!.validate() &&
                        busDocumentId.isNotEmpty) {
                      FirebaseServices services = FirebaseServices();
                      final result = await services.updateDriver(
                        driverDocid: driver.driverDocumentId,
                        busDocumentId: busDocumentId,
                        driverLicense: driverLicense.text,
                        driverName: driverName.text,
                        driverAddress: driverAddress.text,
                        driverPhoneNumber: driverPhoneNumber.text,
                      );
                      if (result.contains('success')) {
                        // ignore: use_build_context_synchronously
                        Helpers.showToast(
                          context: context,
                          title: 'Driver Register Success Fully',
                        );
                        driverName.clear();
                        driverEmail.clear();
                        driverAddress.clear();
                        driverLicense.clear();
                        driverPassword.clear();
                        driverPhoneNumber.clear();
                        busDocumentId = '';
                        Navigator.of(context).pop();
                      } else {
                        // ignore: use_build_context_synchronously
                        Helpers.showToast(
                          context: context,
                          title: result,
                        );
                        driverName.clear();
                        driverEmail.clear();
                        driverAddress.clear();
                        driverLicense.clear();
                        driverPassword.clear();
                        driverPhoneNumber.clear();
                        busDocumentId = '';
                      }
                    }
                  },
                  child: const Text('Register'),
                ),
                TextButton(
                  onPressed: () {
                    driverName.clear();
                    driverEmail.clear();
                    driverAddress.clear();
                    driverLicense.clear();
                    driverPassword.clear();
                    driverPhoneNumber.clear();
                    busDocumentId = '';
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DriverRegisterModelClass>>(
      stream: FirebaseServices.fetchDriverData(),
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
                  dividerThickness: 1,
                  columns: const [
                    DataColumn(
                        label: Text('Driver Name'), tooltip: 'Driver Name'),
                    DataColumn(
                        label: Text('Driver Email'), tooltip: 'Driver Email'),
                    DataColumn(
                        label: Text('Bus Document Id'),
                        tooltip: 'Bus Document Id'),
                    DataColumn(
                        label: Text('Driver Phone No'),
                        tooltip: 'Driver Phone No'),
                    DataColumn(
                        label: Text('Driver Address'),
                        tooltip: 'Driver Address'),
                    DataColumn(
                        label: Text('Driver License Number'),
                        tooltip: 'Driver License Number'),
                    DataColumn(
                        label: Text('Operations'), tooltip: 'Operations'),
                  ],
                  rows: List<DataRow>.generate(snapshot.data!.length, (index) {
                    final driver = snapshot.data![index];
                    return DataRow(
                      cells: [
                        DataCell(Text(driver.driverName)),
                        DataCell(Text(driver.driverEmail)),
                     DataCell(FutureBuilder<DocumentSnapshot>(
          
          future: FirebaseFirestore.instance.collection('Buses').doc(driver.busDocumentId).get(),
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
        )),
                        DataCell(Text(driver.driverPhoneNumber)),
                        DataCell(Text(driver.driverAddress)),
                        DataCell(Text(driver.driverLicenseNumber)),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.green),
                                onPressed: () {
                                  _handleEditOperation(index, context, driver);
                                },
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _showDeleteConfirmationDialog(
                                      driver.driverDocumentId, context);
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
