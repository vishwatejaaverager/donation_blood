import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/directions.dart';

double calculateDistances(double ulat,double ulng,double clat,double clng) {
  var a = Geolocator.distanceBetween(
      ulat, ulng, clat, clng);

  return a;
}
