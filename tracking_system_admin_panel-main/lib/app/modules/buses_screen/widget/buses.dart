import 'package:flutter/material.dart';
import '../../../../sdk/models/bus_register_model_class.dart';
import '../../../../sdk/services/firebase_services.dart';
import '../../../../styles/colors/colors.dart';
import '../../../../utils/helpers.dart';
import '../../../../utils/validations_handler.dart';
import '../../../../widgets/custom_text_field.dart';

// ignore: must_be_immutable
class TabularFormBuses extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController busNumber = TextEditingController();
  TextEditingController morningTimeStartFrom = TextEditingController();
  TextEditingController morningTimeDropOff = TextEditingController();
  TextEditingController eveningTimeStartFrom = TextEditingController();
  TextEditingController eveningTimeDropOff = TextEditingController();

  TabularFormBuses({super.key});

  void _showDeleteConfirmationDialog(String docId, context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this bus?'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);

                await FirebaseServices.deleteBus(docId);
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

  void _handleEditOperation(int rowIndex, context, bus) async {
    busNumber.text = bus.busNumber;
    morningTimeStartFrom.text = bus.morningTimeStartFrom;
    morningTimeDropOff.text = bus.morningTimeDropOff;
    eveningTimeStartFrom.text = bus.eveningTimeStartFrom;
    eveningTimeDropOff.text = bus.eveningTimeDropOff;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 54),
            child: AlertDialog(
              title: const Text('Bus Update'), // Updated heading
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
                      final result = await services.updateBus(
                          busDocId: bus.busDocumentId,
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
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BusRegisterModelClass>>(
      stream: FirebaseServices.fetchBuses(),
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
                        label: Text('Bus Number'), tooltip: 'Bus Number'),
                    DataColumn(
                        label: Text('Morning Time Start'),
                        tooltip: 'Morning Time Start'),
                    DataColumn(
                        label: Text('Morning Time Drop-off'),
                        tooltip: 'Morning Time Drop-off'),
                    DataColumn(
                        label: Text('Evening Time Start'),
                        tooltip: 'Evening Time Start'),
                    DataColumn(
                        label: Text('Evening Time Drop-off'),
                        tooltip: 'Evening Time Drop-off'),
                    DataColumn(label: Text('Latitude'), tooltip: 'Latitude'),
                    DataColumn(label: Text('Longitude'), tooltip: 'Longitude'),
                    DataColumn(
                        label: Text('Operations'), tooltip: 'Operations'),
                  ],
                  rows: List<DataRow>.generate(snapshot.data!.length, (index) {
                    final bus = snapshot.data![index];
                    return DataRow(
                      cells: [
                        DataCell(Text(bus.busNumber)),
                        DataCell(Text(bus.morningTimeStartFrom)),
                        DataCell(Text(bus.morningTimeDropOff)),
                        DataCell(Text(bus.eveningTimeStartFrom)),
                        DataCell(Text(bus.eveningTimeDropOff)),
                        DataCell(Text(bus.latitude.toString())),
                        DataCell(Text(bus.longitude.toString())),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.green),
                                onPressed: () {
                                  _handleEditOperation(index, context, bus);
                                },
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _showDeleteConfirmationDialog(
                                      bus.busDocumentId, context);
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
