class Donation {
  final String donId;
  String organization;
  String userId;
  String address;
  int phone_number;
  DateTime start_date;
  DateTime end_date;

  Donation(
      {this.donId,
      this.organization,
      this.userId,
      this.address,
      this.phone_number,
      this.start_date,
      this.end_date});

  Donation.onlyId({this.donId});

  @override
  bool operator ==(covariant Donation other) => other.donId == this.donId;
}
