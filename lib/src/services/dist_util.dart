import 'package:geolocator/geolocator.dart';

double calculateDistances(double ulat, double ulng, double clat, double clng) {
  var a = Geolocator.distanceBetween(ulat, ulng, clat, clng);

  return a;
}

String calcDistInKms(double ulat, double ulng, double clat, double clng) {
  var b = calculateDistances(ulat, ulng, clat, clng);
  double distanceInKiloMeters = b / 1000;
  double roundDistanceInKM =
      double.parse((distanceInKiloMeters).toStringAsFixed(2));
  return roundDistanceInKM.toString();
}
