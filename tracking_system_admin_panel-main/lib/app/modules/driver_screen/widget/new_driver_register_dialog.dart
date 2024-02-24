import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tracking_system_dashboard/sdk/services/firebase_services.dart';
import 'package:tracking_system_dashboard/styles/styles.dart';
import '../../../../widgets/widget_export.dart';
import '../../../../utils/utils_export.dart';

// ignore: must_be_immutable
class DriverRegisterDialog extends StatelessWidget {
  DriverRegisterDialog({super.key});
  final _formKey = GlobalKey<FormState>();
  TextEditingController driverName = TextEditingController();
  TextEditingController driverEmail = TextEditingController();
  TextEditingController driverPhoneNumber = TextEditingController();
  TextEditingController driverLicense = TextEditingController();
  TextEditingController driverAddress = TextEditingController();
  TextEditingController driverPassword = TextEditingController();

  String busDocumentId = '';

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: CustomFilledButton(
        label: 'Register Driver',
        width: 400,
        height: 124,
        labelStyle: const TextStyle(color: Colors.white),
        backgroundColor: CustomColors.skyBlueColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 54),
                  child: AlertDialog(
                    title: const Text('Driver Register'), // Updated heading
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
                              label: "Driver Email",
                              controller: driverEmail,
                              fillColor: Colors.transparent,
                              labelTextColor: Colors.black87,
                              validator: emailValidator,
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
                            TextInputField(
                              label: "Driver Password",
                              controller: driverPassword,
                              fillColor: Colors.transparent,
                              labelTextColor: Colors.black87,
                              validator: passwordValidator,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("Buses")
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<
                                            QuerySnapshot<Map<String, dynamic>>>
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
                                        dropdownValue: const Text('Select Bus'),
                                        onChanged: (p0) {
                                          var selectedBusDocument = snapshot
                                              .data!.docs
                                              .firstWhere((element) =>
                                                  element['busNumber'] == p0);
                                          var busData =
                                              selectedBusDocument.data();
                                          busDocumentId =
                                              busData['busDocumentId'];
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
                            final result = await services.registerDriver(
                              driverName: driverName.text,
                              driverEmail: driverEmail.text,
                              driverAddress: driverAddress.text,
                              busDocumentId: busDocumentId,
                              driverLicenseNumber: driverLicense.text,
                              driverPassword: driverPassword.text,
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
        },
      ),
    );
  }
}
