import 'package:cloud_firestore/cloud_firestore.dart';

class Streams {
  static const requests = 'yourRequests';
  static const seekersRequest = 'seekersRequest';
  static const user = 'users';
  static const requestByUser = 'requestsByUser';
  static const bloodRequest = 'blood_requests';

  final userQuery = FirebaseFirestore.instance.collection(user);
  final requestQuery = FirebaseFirestore.instance.collection(bloodRequest);
  // final seekerQuery = FirebaseFirestore.instance.collection(seekersRequest);
}
