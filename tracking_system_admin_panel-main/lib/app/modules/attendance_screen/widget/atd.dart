import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../styles/colors/colors.dart';

// ignore: must_be_immutable
class TabularFormBuses extends StatefulWidget {
  TabularFormBuses({super.key});

  @override
  State<TabularFormBuses> createState() => _TabularFormBusesState();
}

class _TabularFormBusesState extends State<TabularFormBuses> {
  late TwilioFlutter twilioFlutter;
  @override
  void initState() {
    twilioFlutter = TwilioFlutter(
        accountSid: 'AC17325f5e84396704895f337fa2009dcc',
        authToken: '97a5125bc24b951e92ad2cbd37618569',
        twilioNumber: '+17075170379');
    super.initState();
  }

  Future<void> _showAttendanceDetails(
      BuildContext context, Map<String, dynamic> data, stdName) async {
    // Build and show the dialog box with attendance details
    await showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        var attendanceList = data['attendanceList'];
        return AlertDialog(
          title: Text('Attendance Details for ${stdName}'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                for (var attendance in attendanceList) ...[
                  ListTile(
                    title: Text(
                        'Check-In Location: ${attendance['checkInLocation']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Check-In Time: ${attendance['checkInTime'].toDate()}'),
                        attendance['checkOutLocation'] == null
                            ? Text("--/--")
                            : Text(
                                'Check-Out Location: ${attendance['checkOutLocation']}'),
                        attendance['checkOutTime'] == null
                            ? Text("--/--")
                            : Text(
                                'Check-Out Time: ${attendance['checkOutTime'].toDate()}'),
                      ],
                    ),
                  ),
                  const Divider(),
                ],
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext); // Close the dialog box
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Attendance').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return const Center(child: Text('Error fetching data'));
        } else if (!snapshot.hasData) {
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
                        label: Text('Student Name'), tooltip: 'Student Name'),
                    DataColumn(
                        label: Text('checkInLocation'),
                        tooltip: 'checkInLocation'),
                    DataColumn(
                        label: Text('checkOutLocation'),
                        tooltip: 'checkOutLocation'),
                    DataColumn(
                        label: Text('checkInTime'), tooltip: 'checkInTime'),
                    DataColumn(
                        label: Text('checkOutTime'), tooltip: 'checkOutTime'),
                    DataColumn(
                        label: Text('Operations'), tooltip: 'Operations'),
                  ],
                  rows: List<DataRow>.generate(snapshot.data!.docs.length, (i) {
                    var data = snapshot.data!.docs[i].data();
                    var stdName = '';
                    return DataRow(
                      cells: [
                        DataCell(FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection('StudentData')
                              .where('studentUserId',
                                  isEqualTo: data['studentUserId'])
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            if (!snapshot.hasData) {
                              return const Text('No data available.');
                            }

                            // Accessing the document's 'studentName' field
                            stdName = snapshot.data!.docs[0].get('studentName');

                            return Text(stdName); // Display student name
                          },
                        )),
                        DataCell(Text(data['attendanceList'][0]
                                ['checkInLocation'] ??
                            "--/--")),
                        DataCell(Text(data['attendanceList'][0]
                                ['checkOutLocation'] ??
                            "--/--")),
                        DataCell(
                            data['attendanceList'][0]['checkInTime'] == null
                                ? Text("--/--")
                                : Text(
                                    data['attendanceList'][0]['checkInTime']
                                        .toDate()
                                        .toString(),
                                  )),
                        DataCell(
                          data['attendanceList'][0]['checkOutTime'] == null
                              ? Text("--/--")
                              : Text(
                                  data['attendanceList'][0]['checkOutTime']
                                      .toDate()
                                      .toString(),
                                ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.details,
                                    color: Colors.green),
                                onPressed: () {
                                  _showAttendanceDetails(
                                      context, data, stdName);
                                },
                              ),
                              data['attendanceList'][0]['checkOutTime'] == null
                                  ? SizedBox()
                                  : IconButton(
                                      icon: const Icon(
                                          Icons.notifications_on_outlined,
                                          color: Colors.green),
                                      onPressed: () async {
                                        String? name = await getUserGmailNumber(
                                            data['studentUserId']);
                                        if (name == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    "User's phone number not found.")),
                                          );
                                        } else {
                                          // ignore: use_build_context_synchronously
                                          sendSms(name);
                                        }
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

  Future<String?> getUserGmailNumber(String studentUserId) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('StudentData')
        .where('studentUserId', isEqualTo: studentUserId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs[0].get('studentName') as String;
    }

    return null; // Return null if user not found
  }

  void sendSms(name) async {
    twilioFlutter.sendSMS(
        toNumber: '+923426045849',
        messageBody:
            'UOG Bus Tracking System Alert\n$name has reached their destination successfully.');
  }
}
