// ignore_for_file: depend_on_referenced_packages, curly_braces_in_flow_control_structures

import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_with_markers/services/supbase_survice.dart';

class LocationController extends GetxController {
  final SupabaseService _service = SupabaseService();

  Rx<LatLng?> myLocation = Rx<LatLng?>(null);
  Rx<LatLng?> otherLocation = Rx<LatLng?>(null);

  final String myId = 'user1';
  final String otherId = 'user2';

  @override
  void onInit() {
    super.onInit();
    _getMyLocation();
    _listenToOther();
  }

  void _getMyLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) return;

    // أول موقع معروف فورًا
    Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    myLocation.value = LatLng(pos.latitude, pos.longitude);
    _service.updateLocation(myId, pos.latitude, pos.longitude);

    // Stream لتحديث الموقع باستمرار
    Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((Position pos) {
      myLocation.value = LatLng(pos.latitude, pos.longitude);
      _service.updateLocation(myId, pos.latitude, pos.longitude);
    });
  }

  void _listenToOther() {
    _service.listenToOtherUser(otherId, (data) {
      otherLocation.value = LatLng(data['lat'], data['lng']);
    });
  }
}


