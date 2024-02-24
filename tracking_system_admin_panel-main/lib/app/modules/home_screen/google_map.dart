import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapScreen extends StatelessWidget {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _firebaseFirestore.collection("Buses").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error fetching data'),
          );
        } else {
          final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
              snapshot.data!.docs;

          if (documents.isEmpty) {
            return const Center(
              child: Text('No Data'),
            );
          }

          final List<Marker> markers = documents
              .map(
                (doc) => Marker(
                  markerId: MarkerId(doc.id),
                  position: LatLng(
                    doc['latitude'] as double,
                    doc['longitude'] as double,
                  ),
                  infoWindow: InfoWindow(
                      title: 'Bus Number: ${doc['busNumber']}\n'
                          'Morning Start Time: ${doc['morningTimeStartFrom']}\n'
                          'Morning Drop-off Time: ${doc['morningTimeDropOff']}\n'
                          'Evening Start Time: ${doc['eveningTimeStartFrom']}\n'
                          'Evening Drop-off Time: ${doc['eveningTimeDropOff']}',
                      snippet: ''),
                ),
              )
              .toList();

          final LatLngBounds bounds = LatLngBounds(
            southwest: LatLng(
              markers.map((marker) => marker.position.latitude).reduce(min),
              markers.map((marker) => marker.position.longitude).reduce(min),
            ),
            northeast: LatLng(
              markers.map((marker) => marker.position.latitude).reduce(max),
              markers.map((marker) => marker.position.longitude).reduce(max),
            ),
          );

          return GoogleMap(
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
              target: bounds.northeast, // Center of the LatLngBounds
              zoom: 13.0, // Initial zoom level
            ),
            markers: Set<Marker>.of(markers),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          );
        }
      },
    );
  }
}
