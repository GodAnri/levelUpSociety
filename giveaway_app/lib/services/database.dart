import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:giveaway_app/models/donation.dart';
import 'package:giveaway_app/models/user.dart';

class DatabaseService {
  final String uid; // User Id
  DatabaseService({this.uid});

  // COLLECTIONS
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference donationsCollection =
      FirebaseFirestore.instance.collection("donations");

  // PROFILE DATA

  // Update User Profile - Coins
  Future<void> updateProfile(int coins) async {
    return await users.doc(uid).set({"coins": coins});
  }

  // Transform database user profile info into a instance of UserData
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    print(uid);
    return UserData(
      uid: uid,
      coins: snapshot.data()['coins'],
    );
  }

  // Get UserData stream
  Stream<UserData> get userData {
    print("ola");
    return users.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  // Get Categories Stream
  Stream<List<String>> get categories {
    return donationsCollection.snapshots().map(_categoryListFromSnapshot);
  }

  // Transform database Conference Categories into a List of category names
  List<String> _categoryListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) {
          return doc.data()['category'].toString();
        })
        .toSet()
        .toList();
  }

  // DONATIONS DATA

  // Transform database conference info into a list of Conference
  List<Donation> _conferenceListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((don) {
      return Donation(
        donId: don.id,
      );
    }).toList();
  }

  // Get Conferences stream
  Stream<List<Donation>> get donations {
    return donationsCollection.snapshots().map(_conferenceListFromSnapshot);
  }

  // Insert Donation into Database
  addConference(Donation donation) async {
    var newConference = await donationsCollection.doc();

    newConference.set({
      'address': donation.address,
      'end_date': donation.end_date,
      'organization': donation.organization,
      'phone_number': donation.phone_number,
      'start_date': donation.start_date,
      'userId': donation.userId,
    });

    return newConference.id;
  }
}
