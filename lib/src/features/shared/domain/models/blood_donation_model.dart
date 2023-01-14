// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BloodDonationModel {
  String? patientName;
  String? number;
  String? bloodGroup;
  String? donationStat;
  String? units;
  String? donatedUnits;
  String? deadLine;
  String? location;
  bool? isEmergency;
  num? lat;
  num? long;
  BloodDonationModel({
    this.patientName,
    this.number,
    this.bloodGroup,
    this.donationStat,
    this.units,
    this.donatedUnits,
    this.deadLine,
    this.location,
    this.isEmergency,
    this.lat,
    this.long,
  });

  BloodDonationModel copyWith({
    String? patientName,
    String? number,
    String? bloodGroup,
    String? donationStat,
    String? units,
    String? donatedUnits,
    String? deadLine,
    String? location,
    bool? isEmergency,
    num? lat,
    num? long,
  }) {
    return BloodDonationModel(
      patientName: patientName ?? this.patientName,
      number: number ?? this.number,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      donationStat: donationStat ?? this.donationStat,
      units: units ?? this.units,
      donatedUnits: donatedUnits ?? this.donatedUnits,
      deadLine: deadLine ?? this.deadLine,
      location: location ?? this.location,
      isEmergency: isEmergency ?? this.isEmergency,
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'patientName': patientName,
      'number': number,
      'bloodGroup': bloodGroup,
      'donationStat': donationStat,
      'units': units,
      'donatedUnits': donatedUnits,
      'deadLine': deadLine,
      'location': location,
      'isEmergency': isEmergency,
      'lat': lat,
      'long': long,
    };
  }

  factory BloodDonationModel.fromMap(Map<String, dynamic> map) {
    return BloodDonationModel(
      patientName: map['patientName'] != null ? map['patientName'] as String : null,
      number: map['number'] != null ? map['number'] as String : null,
      bloodGroup: map['bloodGroup'] != null ? map['bloodGroup'] as String : null,
      donationStat: map['donationStat'] != null ? map['donationStat'] as String : null,
      units: map['units'] != null ? map['units'] as String : null,
      donatedUnits: map['donatedUnits'] != null ? map['donatedUnits'] as String : null,
      deadLine: map['deadLine'] != null ? map['deadLine'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      isEmergency: map['isEmergency'] != null ? map['isEmergency'] as bool : null,
      lat: map['lat'] != null ? map['lat'] as num : null,
      long: map['long'] != null ? map['long'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BloodDonationModel.fromJson(String source) =>
      BloodDonationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BloodDonationModel(patientName: $patientName, number: $number, bloodGroup: $bloodGroup, donationStat: $donationStat, units: $units, donatedUnits: $donatedUnits, deadLine: $deadLine, location: $location, isEmergency: $isEmergency, lat: $lat, long: $long)';
  }

  @override
  bool operator ==(covariant BloodDonationModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.patientName == patientName &&
      other.number == number &&
      other.bloodGroup == bloodGroup &&
      other.donationStat == donationStat &&
      other.units == units &&
      other.donatedUnits == donatedUnits &&
      other.deadLine == deadLine &&
      other.location == location &&
      other.isEmergency == isEmergency &&
      other.lat == lat &&
      other.long == long;
  }

  @override
  int get hashCode {
    return patientName.hashCode ^
      number.hashCode ^
      bloodGroup.hashCode ^
      donationStat.hashCode ^
      units.hashCode ^
      donatedUnits.hashCode ^
      deadLine.hashCode ^
      location.hashCode ^
      isEmergency.hashCode ^
      lat.hashCode ^
      long.hashCode;
  }
}
