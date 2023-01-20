// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class InterestedDonarsModel {
  String? userFrom;
  String? userTo;
  String? donationId;
  String? donarStat;
  InterestedDonarsModel({
    this.userFrom,
    this.userTo,
    this.donationId,
    this.donarStat,
  });

  InterestedDonarsModel copyWith({
    String? userFrom,
    String? userTo,
    String? donationId,
    String? donarStat,
  }) {
    return InterestedDonarsModel(
      userFrom: userFrom ?? this.userFrom,
      userTo: userTo ?? this.userTo,
      donationId: donationId ?? this.donationId,
      donarStat: donarStat ?? this.donarStat,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userFrom': userFrom,
      'userTo': userTo,
      'donationId': donationId,
      'donarStat': donarStat,
    };
  }

  factory InterestedDonarsModel.fromMap(Map<String, dynamic> map) {
    return InterestedDonarsModel(
      userFrom: map['userFrom'] != null ? map['userFrom'] as String : null,
      userTo: map['userTo'] != null ? map['userTo'] as String : null,
      donationId: map['donationId'] != null ? map['donationId'] as String : null,
      donarStat: map['donarStat'] != null ? map['donarStat'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InterestedDonarsModel.fromJson(String source) =>
      InterestedDonarsModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InterestedDonarsModel(userFrom: $userFrom, userTo: $userTo, donationId: $donationId, donarStat: $donarStat)';
  }

  @override
  bool operator ==(covariant InterestedDonarsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.userFrom == userFrom &&
      other.userTo == userTo &&
      other.donationId == donationId &&
      other.donarStat == donarStat;
  }

  @override
  int get hashCode {
    return userFrom.hashCode ^
      userTo.hashCode ^
      donationId.hashCode ^
      donarStat.hashCode;
  }
}
