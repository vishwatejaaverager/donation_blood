// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BloodDonationModel {
  String? userId;
  String? patientName;
  String? number;
  String? bloodGroup;
  String? donationStat;
  String? units;
  String? donatedUnits;
  String? deadLine;
  String? location;
  bool? isEmergency;
  List? intrestedDonars;
  num? lat;
  num? long;
  String? image;
  
  String? name;
  String? donationId;
  BloodDonationModel(
      {this.userId,
      this.patientName,
      this.number,
      this.bloodGroup,
      this.donationStat,
      this.units,
      this.donatedUnits,
      this.deadLine,
      this.location,
      this.isEmergency,
      this.intrestedDonars,
      this.lat,
      this.long,
      this.image,
      this.name,
      this.donationId});

  BloodDonationModel copyWith(
      {String? userId,
      String? patientName,
      String? number,
      String? bloodGroup,
      String? donationStat,
      String? units,
      String? donatedUnits,
      String? deadLine,
      String? location,
      bool? isEmergency,
      List? intrestedDonars,
      num? lat,
      num? long,
      String? image,
      String? name,
      String? donationId}) {
    return BloodDonationModel(
        userId: userId ?? this.userId,
        patientName: patientName ?? this.patientName,
        number: number ?? this.number,
        bloodGroup: bloodGroup ?? this.bloodGroup,
        donationStat: donationStat ?? this.donationStat,
        units: units ?? this.units,
        donatedUnits: donatedUnits ?? this.donatedUnits,
        deadLine: deadLine ?? this.deadLine,
        location: location ?? this.location,
        isEmergency: isEmergency ?? this.isEmergency,
        intrestedDonars: intrestedDonars ?? this.intrestedDonars,
        lat: lat ?? this.lat,
        long: long ?? this.long,
        image: image ?? this.image,
        name: name ?? this.name,
        donationId: donationId ?? this.donationId);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'patientName': patientName,
      'number': number,
      'bloodGroup': bloodGroup,
      'donationStat': donationStat,
      'units': units,
      'donatedUnits': donatedUnits,
      'deadLine': deadLine,
      'location': location,
      'isEmergency': isEmergency,
      'intrestedDonars': intrestedDonars?.toList(),
      'lat': lat,
      'long': long,
      'image': image,
      'name': name,
      'donationId': donationId
    };
  }

  factory BloodDonationModel.fromMap(Map<String, dynamic> map) {
    return BloodDonationModel(
        userId: map['userId'] != null ? map['userId'] as String : null,
        patientName:
            map['patientName'] != null ? map['patientName'] as String : null,
        number: map['number'] != null ? map['number'] as String : null,
        bloodGroup:
            map['bloodGroup'] != null ? map['bloodGroup'] as String : null,
        donationStat:
            map['donationStat'] != null ? map['donationStat'] as String : null,
        units: map['units'] != null ? map['units'] as String : null,
        donatedUnits:
            map['donatedUnits'] != null ? map['donatedUnits'] as String : null,
        deadLine: map['deadLine'] != null ? map['deadLine'] as String : null,
        location: map['location'] != null ? map['location'] as String : null,
        isEmergency:
            map['isEmergency'] != null ? map['isEmergency'] as bool : null,
        intrestedDonars: map['intrestedDonars'] != null
            ? List.from(map['intrestedDonars'] as List)
            : null,
        lat: map['lat'] != null ? map['lat'] as num : null,
        long: map['long'] != null ? map['long'] as num : null,
        image: map['image'] != null ? map['image'] as String : null,
        name: map['name'] != null ? map['name'] as String : null,
        donationId:
            map['donationId'] != null ? map['donationId'] as String : null);
  }

  String toJson() => json.encode(toMap());

  factory BloodDonationModel.fromJson(String source) =>
      BloodDonationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BloodDonationModel(userId: $userId, patientName: $patientName, number: $number, bloodGroup: $bloodGroup, donationStat: $donationStat, units: $units, donatedUnits: $donatedUnits, deadLine: $deadLine, location: $location, isEmergency: $isEmergency, intrestedDonars: $intrestedDonars, lat: $lat, long: $long, image: $image,name : $name,donationId:$donationId)';
  }

  @override
  bool operator ==(covariant BloodDonationModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.patientName == patientName &&
        other.number == number &&
        other.bloodGroup == bloodGroup &&
        other.donationStat == donationStat &&
        other.units == units &&
        other.donatedUnits == donatedUnits &&
        other.deadLine == deadLine &&
        other.location == location &&
        other.isEmergency == isEmergency &&
        other.intrestedDonars == intrestedDonars &&
        other.lat == lat &&
        other.long == long &&
        other.image == image &&
        other.name == name &&
        other.donationId == donationId;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        patientName.hashCode ^
        number.hashCode ^
        bloodGroup.hashCode ^
        donationStat.hashCode ^
        units.hashCode ^
        donatedUnits.hashCode ^
        deadLine.hashCode ^
        location.hashCode ^
        isEmergency.hashCode ^
        intrestedDonars.hashCode ^
        lat.hashCode ^
        long.hashCode ^
        image.hashCode ^
        name.hashCode ^
        donationId.hashCode;
  }
}
