// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import '../controllers/location_controller.dart';

class MapView extends StatelessWidget {
  final LocationController locC = Get.find();
  final MapController _mapController = MapController();

  MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Live Tracking")),
      body: Obx(() {
        List<Marker> markers = [];
        List<LatLng> polylinePoints = [];

        if (locC.myLocation.value != null) {
          markers.add(Marker(
            point: locC.myLocation.value!,
            width: 40,
            height: 40,
            child: Icon(Icons.person_pin_circle, color: Colors.blue, size: 40),
          ));
          polylinePoints.add(locC.myLocation.value!);

          _mapController.move(locC.myLocation.value!, 15);
        }

        if (locC.otherLocation.value != null) {
          markers.add(Marker(
            point: locC.otherLocation.value!,
            width: 40,
            height: 40,
            child: Icon(Icons.location_on, color: Colors.red, size: 40),
          ));
          polylinePoints.add(locC.otherLocation.value!);
        }

        return FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: locC.myLocation.value ?? LatLng(30.0444, 31.2357),
            initialZoom: 15,
            maxZoom: 18,
            minZoom: 3,
          ),
          children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: "com.example.app",
            ),
            if (markers.isNotEmpty) MarkerLayer(markers: markers),
            if (polylinePoints.length == 2)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: polylinePoints,
                    color: Colors.green,
                    strokeWidth: 4,
                  ),
                ],
              ),
          ],
        );
      }),
    );
  }
}
