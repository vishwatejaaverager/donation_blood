// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BloodRequestModel {
  String? name;
  String? image;
  String? phone;
  String? userFrom;
  String? userTo;
  String? distance;
  String? note;
  String? location;
  String? patientName;
  String? deadLine;
  String? bloodGroup;
  String? reqStat;
  bool? isEmergency;
  BloodRequestModel({
    this.name,
    this.image,
    this.phone,
    this.userFrom,
    this.userTo,
    this.distance,
    this.note,
    this.location,
    this.patientName,
    this.deadLine,
    this.bloodGroup,
    this.reqStat,
    this.isEmergency,
  });

  BloodRequestModel copyWith({
    String? name,
    String? image,
    String? phone,
    String? userFrom,
    String? userTo,
    String? distance,
    String? note,
    String? location,
    String? patientName,
    String? deadLine,
    String? bloodGroup,
    String? reqStat,
    bool? isEmergency,
  }) {
    return BloodRequestModel(
      name: name ?? this.name,
      image: image ?? this.image,
      phone: phone ?? this.phone,
      userFrom: userFrom ?? this.userFrom,
      userTo: userTo ?? this.userTo,
      distance: distance ?? this.distance,
      note: note ?? this.note,
      location: location ?? this.location,
      patientName: patientName ?? this.patientName,
      deadLine: deadLine ?? this.deadLine,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      reqStat: reqStat ?? this.reqStat,
      isEmergency: isEmergency ?? this.isEmergency,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image': image,
      'phone': phone,
      'userFrom': userFrom,
      'userTo': userTo,
      'distance': distance,
      'note': note,
      'location': location,
      'patientName': patientName,
      'deadLine': deadLine,
      'bloodGroup': bloodGroup,
      'reqStat': reqStat,
      'isEmergency': isEmergency,
    };
  }

  factory BloodRequestModel.fromMap(Map<String, dynamic> map) {
    return BloodRequestModel(
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      userFrom: map['userFrom'] != null ? map['userFrom'] as String : null,
      userTo: map['userTo'] != null ? map['userTo'] as String : null,
      distance: map['distance'] != null ? map['distance'] as String : null,
      note: map['note'] != null ? map['note'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      patientName: map['patientName'] != null ? map['patientName'] as String : null,
      deadLine: map['deadLine'] != null ? map['deadLine'] as String : null,
      bloodGroup: map['bloodGroup'] != null ? map['bloodGroup'] as String : null,
      reqStat: map['reqStat'] != null ? map['reqStat'] as String : null,
      isEmergency: map['isEmergency'] != null ? map['isEmergency'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BloodRequestModel.fromJson(String source) =>
      BloodRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BloodRequestModel(name: $name, image: $image, phone: $phone, userFrom: $userFrom, userTo: $userTo, distance: $distance, note: $note, location: $location, patientName: $patientName, deadLine: $deadLine, bloodGroup: $bloodGroup, reqStat: $reqStat, isEmergency: $isEmergency)';
  }

  @override
  bool operator ==(covariant BloodRequestModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.image == image &&
      other.phone == phone &&
      other.userFrom == userFrom &&
      other.userTo == userTo &&
      other.distance == distance &&
      other.note == note &&
      other.location == location &&
      other.patientName == patientName &&
      other.deadLine == deadLine &&
      other.bloodGroup == bloodGroup &&
      other.reqStat == reqStat &&
      other.isEmergency == isEmergency;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      image.hashCode ^
      phone.hashCode ^
      userFrom.hashCode ^
      userTo.hashCode ^
      distance.hashCode ^
      note.hashCode ^
      location.hashCode ^
      patientName.hashCode ^
      deadLine.hashCode ^
      bloodGroup.hashCode ^
      reqStat.hashCode ^
      isEmergency.hashCode;
  }
}
