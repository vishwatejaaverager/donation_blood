// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class InterestedDonarsModel {
  String? userFrom;
  String? userTo;
  String? donarsNumber;
  String? donationId;
  String? donarStat;
  String? donarName;
  String? donarImage;
  String? bloodGroup;
  num? lat;
  num? lng;
  String? location;
  InterestedDonarsModel({
    this.userFrom,
    this.userTo,
    this.donarsNumber,
    this.donationId,
    this.donarStat,
    this.donarName,
    this.donarImage,
    this.bloodGroup,
    this.lat,
    this.lng,
    this.location,
  });

  InterestedDonarsModel copyWith({
    String? userFrom,
    String? userTo,
    String? donarsNumber,
    String? donationId,
    String? donarStat,
    String? donarName,
    String? donarImage,
    String? bloodGroup,
    num? lat,
    num? lng,
    String? location,
  }) {
    return InterestedDonarsModel(
      userFrom: userFrom ?? this.userFrom,
      userTo: userTo ?? this.userTo,
      donarsNumber: donarsNumber ?? this.donarsNumber,
      donationId: donationId ?? this.donationId,
      donarStat: donarStat ?? this.donarStat,
      donarName: donarName ?? this.donarName,
      donarImage: donarImage ?? this.donarImage,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userFrom': userFrom,
      'userTo': userTo,
      'donarsNumber': donarsNumber,
      'donationId': donationId,
      'donarStat': donarStat,
      'donarName': donarName,
      'donarImage': donarImage,
      'bloodGroup': bloodGroup,
      'lat': lat,
      'lng': lng,
      'location': location,
    };
  }

  factory InterestedDonarsModel.fromMap(Map<String, dynamic> map) {
    return InterestedDonarsModel(
      userFrom: map['userFrom'] != null ? map['userFrom'] as String : null,
      userTo: map['userTo'] != null ? map['userTo'] as String : null,
      donarsNumber: map['donarsNumber'] != null ? map['donarsNumber'] as String : null,
      donationId: map['donationId'] != null ? map['donationId'] as String : null,
      donarStat: map['donarStat'] != null ? map['donarStat'] as String : null,
      donarName: map['donarName'] != null ? map['donarName'] as String : null,
      donarImage: map['donarImage'] != null ? map['donarImage'] as String : null,
      bloodGroup: map['bloodGroup'] != null ? map['bloodGroup'] as String : null,
      lat: map['lat'] != null ? map['lat'] as num : null,
      lng: map['lng'] != null ? map['lng'] as num : null,
      location: map['location'] != null ? map['location'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InterestedDonarsModel.fromJson(String source) =>
      InterestedDonarsModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InterestedDonarsModel(userFrom: $userFrom, userTo: $userTo, donarsNumber: $donarsNumber, donationId: $donationId, donarStat: $donarStat, donarName: $donarName, donarImage: $donarImage, bloodGroup: $bloodGroup, lat: $lat, lng: $lng, location: $location)';
  }

  @override
  bool operator ==(covariant InterestedDonarsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.userFrom == userFrom &&
      other.userTo == userTo &&
      other.donarsNumber == donarsNumber &&
      other.donationId == donationId &&
      other.donarStat == donarStat &&
      other.donarName == donarName &&
      other.donarImage == donarImage &&
      other.bloodGroup == bloodGroup &&
      other.lat == lat &&
      other.lng == lng &&
      other.location == location;
  }

  @override
  int get hashCode {
    return userFrom.hashCode ^
      userTo.hashCode ^
      donarsNumber.hashCode ^
      donationId.hashCode ^
      donarStat.hashCode ^
      donarName.hashCode ^
      donarImage.hashCode ^
      bloodGroup.hashCode ^
      lat.hashCode ^
      lng.hashCode ^
      location.hashCode;
  }
}
