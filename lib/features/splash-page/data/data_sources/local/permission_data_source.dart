import 'package:geolocator/geolocator.dart';

class PermissionDataSource {
  Future<bool> _checkPermission() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> requestPermission() async {
    bool isPermitted = await _checkPermission();
    if (isPermitted) {
      return true;
    } else {
      final LocationPermission permission =
          await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return false;
      } else {
        return true;
      }
    }
  }
}
