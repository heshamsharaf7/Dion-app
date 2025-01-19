import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentLocation() async {
  try {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position p = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print(p);
    return p;
  } catch (e) {
    print('Error getting current location: $e');
    throw e; // Rethrow the caught exception
  }
}