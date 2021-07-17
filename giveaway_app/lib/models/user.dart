class SmartconUser {
  final String uid;

  SmartconUser({this.uid});
}

class UserData {
  final String uid;
  final String district;
  final List<String> interests;

  UserData({this.uid, this.district, this.interests});
}

class UserConference {
  final String uid;
  final String conferenceId;
  final List<String> sessions;

  UserConference({this.uid, this.conferenceId, this.sessions});
}