// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserProfile {
  String? name;
  String? age;
  String? gender;
  String? bloodGroup;
  String? medIssues;
  String? location;
  String? profileImage;
  num? lat;
  num? long;
  String? phone;
  bool? isAvailable;
  String? donatedTime;

  String? userId;
  UserProfile({
    this.name,
    this.age,
    this.gender,
    this.bloodGroup,
    this.medIssues,
    this.location,
    this.profileImage,
    this.lat,
    this.long,
    this.phone,
    this.isAvailable,
    this.donatedTime,
    this.userId,
  });

  UserProfile copyWith({
    String? name,
    String? age,
    String? gender,
    String? bloodGroup,
    String? medIssues,
    String? location,
    String? profileImage,
    num? lat,
    num? long,
    String? phone,
    bool? isAvailable,
    String? donatedTime,
    String? userId,
  }) {
    return UserProfile(
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      medIssues: medIssues ?? this.medIssues,
      location: location ?? this.location,
      profileImage: profileImage ?? this.profileImage,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      phone: phone ?? this.phone,
      isAvailable: isAvailable ?? this.isAvailable,
      donatedTime: donatedTime ?? this.donatedTime,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'age': age,
      'gender': gender,
      'bloodGroup': bloodGroup,
      'medIssues': medIssues,
      'location': location,
      'profileImage': profileImage,
      'lat': lat,
      'long': long,
      'phone': phone,
      'isAvailable': isAvailable,
      'donatedTime': donatedTime,
      'userId': userId,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      name: map['name'] != null ? map['name'] as String : null,
      age: map['age'] != null ? map['age'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      bloodGroup: map['bloodGroup'] != null ? map['bloodGroup'] as String : null,
      medIssues: map['medIssues'] != null ? map['medIssues'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      profileImage: map['profileImage'] != null ? map['profileImage'] as String : null,
      lat: map['lat'] != null ? map['lat'] as num : null,
      long: map['long'] != null ? map['long'] as num : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      isAvailable: map['isAvailable'] != null ? map['isAvailable'] as bool : null,
      donatedTime: map['donatedTime'] != null ? map['donatedTime'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserProfile(name: $name, age: $age, gender: $gender, bloodGroup: $bloodGroup, medIssues: $medIssues, location: $location, profileImage: $profileImage, lat: $lat, long: $long, phone: $phone, isAvailable: $isAvailable, donatedTime: $donatedTime, userId: $userId)';
  }

  @override
  bool operator ==(covariant UserProfile other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.age == age &&
      other.gender == gender &&
      other.bloodGroup == bloodGroup &&
      other.medIssues == medIssues &&
      other.location == location &&
      other.profileImage == profileImage &&
      other.lat == lat &&
      other.long == long &&
      other.phone == phone &&
      other.isAvailable == isAvailable &&
      other.donatedTime == donatedTime &&
      other.userId == userId;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      age.hashCode ^
      gender.hashCode ^
      bloodGroup.hashCode ^
      medIssues.hashCode ^
      location.hashCode ^
      profileImage.hashCode ^
      lat.hashCode ^
      long.hashCode ^
      phone.hashCode ^
      isAvailable.hashCode ^
      donatedTime.hashCode ^
      userId.hashCode;
  }
}
