import 'package:flutter/material.dart';
import 'package:tracking_system_dashboard/sdk/services/firebase_services.dart';
import '../../../../widgets/widget_export.dart';
import '../../../../utils/utils_export.dart';
import '../../../../styles/styles.dart';

// ignore: must_be_immutable
class BusRegisterDialog extends StatelessWidget {
  BusRegisterDialog({
    super.key,
  });
  final _formKey = GlobalKey<FormState>();
  TextEditingController busNumber = TextEditingController();
  TextEditingController morningTimeStartFrom = TextEditingController();
  TextEditingController morningTimeDropOff = TextEditingController();
  TextEditingController eveningTimeStartFrom = TextEditingController();
  TextEditingController eveningTimeDropOff = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: CustomFilledButton(
        label: 'Add New Bus',
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
                    title: const Text('Bus Register'), // Updated heading
                    content: Container(
                      color: Colors.white,
                      width: 800,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextInputField(
                              label: "Bus Number",
                              controller: busNumber,
                              fillColor: Colors.transparent,
                              labelTextColor: Colors.black87,
                              validator: requiredValidator,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Morning Route',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextInputField(
                              label: "Start From",
                              controller: morningTimeStartFrom,
                              fillColor: Colors.transparent,
                              labelTextColor: Colors.black87,
                              validator: requiredValidator,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextInputField(
                              label: "Drop Off",
                              controller: morningTimeDropOff,
                              fillColor: Colors.transparent,
                              labelTextColor: Colors.black87,
                              validator: requiredValidator,
                            ),
                            const Text(
                              'Evening Route',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextInputField(
                              label: "Start From",
                              controller: eveningTimeStartFrom,
                              fillColor: Colors.transparent,
                              labelTextColor: Colors.black87,
                              validator: requiredValidator,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextInputField(
                              label: "Drop Off",
                              controller: eveningTimeDropOff,
                              fillColor: Colors.transparent,
                              labelTextColor: Colors.black87,
                              validator: requiredValidator,
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            FirebaseServices services = FirebaseServices();
                            final result = await services.registerBus(
                                busNumber: busNumber.text,
                                morningTimeStartFrom: morningTimeStartFrom.text,
                                morningTimeDropOff: morningTimeDropOff.text,
                                eveningTimeStartFrom: eveningTimeStartFrom.text,
                                eveningTimeDropOff: eveningTimeDropOff.text);
                            if (result.contains('success')) {
                              // ignore: use_build_context_synchronously
                              Helpers.showToast(
                                context: context,
                                title: 'Bus Register Success Fully',
                              );
                              busNumber.clear();
                              morningTimeStartFrom.clear();
                              morningTimeDropOff.clear();
                              eveningTimeStartFrom.clear();
                              eveningTimeDropOff.clear();
                              Navigator.of(context).pop();
                            } else {
                              // ignore: use_build_context_synchronously
                              Helpers.showToast(
                                context: context,
                                title: result,
                              );
                              busNumber.clear();
                              morningTimeStartFrom.clear();
                              morningTimeDropOff.clear();
                              eveningTimeStartFrom.clear();
                              eveningTimeDropOff.clear();
                            }
                          }
                        },
                        child: const Text('Register'),
                      ),
                      TextButton(
                        onPressed: () {
                          busNumber.clear();
                          morningTimeStartFrom.clear();
                          morningTimeDropOff.clear();
                          eveningTimeStartFrom.clear();
                          eveningTimeDropOff.clear();
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
